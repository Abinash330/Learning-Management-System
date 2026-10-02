package com.example.lms.config;

import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import jakarta.servlet.DispatcherType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import java.util.Optional;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final UserRepository userRepository;

    @Autowired
    public SecurityConfig(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .dispatcherTypeMatchers(
                    DispatcherType.FORWARD,
                    DispatcherType.INCLUDE,
                    DispatcherType.ERROR,
                    DispatcherType.ASYNC
                ).permitAll()
                .requestMatchers(
                    "/", "/index", "/home", "/dashboard",
                    "/login", "/register", "/about", "/contact", "/faq",
                    "/test", "/calclulate",
                    "/css/**", "/js/**", "/image/**", "/images/**", "/static/**", "/assets/**",
                    "/api/notices", "/error"
                ).permitAll()
                .requestMatchers(
                    "/admin/**", "/adashboard", "/users", "/admin-add", "/updateusers", "/edituser",
                    "/broadcast-email", "/broadcast-log", "/admin-notices", "/admin-notices/**",
                    "/admin-courses", "/admin-courses/**",
                    "/admin-departments", "/admin-departments/**",
                    "/admin-metrics",
                    "/admin/videos", "/admin/videos/**",
                    "/admin/doubts", "/admin/doubts/**",
                    "/doubts/delete/**"
                ).hasRole("ADMIN")
                .requestMatchers(
                    "/addnotice",
                    "/faculty-notices", "/faculty-notices/**",
                    "/videos", "/videos/upload", "/videos/edit/**", "/videos/delete/**",
                    "/doubts", "/doubts/reply/**"
                ).hasAnyRole("ADMIN", "FACULTY")
                .requestMatchers(
                    "/faculty/**", "/fdashboard", "/f-assignments", "/f-create-assignment", "/f-grade"
                ).hasRole("FACULTY")
                .requestMatchers(
                    "/student/**", "/sdashboard", "/s-courses", "/s-browse-courses", "/s-enroll",
                    "/s-assignments", "/s-start-course", "/s-premium", "/s-search", "/s-profile",
                    "/s-update-profile", "/s-submit", "/student-notices", "/student-exams",
                    "/s-videos", "/s-watch/**", "/s-ask-doubt"
                ).hasAnyRole("ADMIN", "STUDENT")
                .requestMatchers(
                    "/videos/stream/**"
                ).hasAnyRole("ADMIN", "STUDENT", "FACULTY")
                .requestMatchers(
                    "/download/notice/**"
                ).authenticated()
                .anyRequest().authenticated()
            ).formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("email")
                .successHandler(authenticationSuccessHandler())
                .failureUrl("/login?error=true")
                .permitAll())
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .permitAll());
        return http.build();
    }

    @Bean
    public org.springframework.security.web.authentication.AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            String email = authentication.getName();
            
            Optional<User> userOpt = userRepository.findByEmail(email);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                request.getSession().setAttribute("name", user.getName());
                request.getSession().setAttribute("email", user.getEmail());
                request.getSession().setAttribute("role", user.getRole());
                
                user.setIsOnline(1);
                userRepository.save(user);
            }

            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
            boolean isFaculty = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_FACULTY"));
            boolean isStudent = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_STUDENT"));
            
            if (isAdmin) {
                response.sendRedirect("/adashboard");
            } else if (isFaculty) {
                response.sendRedirect("/fdashboard");
            } else if (isStudent) {
                response.sendRedirect("/sdashboard");
            } else {
                response.sendRedirect("/dashboard");
            }
        };
    }

    @Bean
    public org.springframework.security.core.userdetails.UserDetailsService userDetailsService() {
        return username -> {
            Optional<User> userOpt = userRepository.findByEmail(username);
            if (userOpt.isEmpty()) {
                throw new org.springframework.security.core.userdetails.UsernameNotFoundException("User not found");
            }
            User user = userOpt.get();
            return org.springframework.security.core.userdetails.User
                    .withUsername(user.getEmail())
                    .password(user.getPassword())
                    .roles(user.getRole().toUpperCase())
                    .disabled(user.getStatus() == null || user.getStatus() != 1)
                    .build();
        };
    }

    @Bean
    public org.springframework.security.crypto.password.PasswordEncoder passwordEncoder() {
        return org.springframework.security.crypto.password.NoOpPasswordEncoder.getInstance();
    }
}
