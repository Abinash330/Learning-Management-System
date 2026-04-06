package com.example.lms.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.lms.model.User;
import com.example.lms.repository.UserRepository;

import java.util.Optional;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private UserRepository userRepository;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
        http
            .csrf(csrf ->csrf.disable())// Disable CSRF for simplicity
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/", "/dashboard",
                    "/login", "/register", "/about", "/contact", "/faq",
                    "/css/**", "/js/**", "/images/**", "/static/**", "/assets/**",
                    "/greet/**", "/car/**", "/hello/**", "/hi/**", "/welcome/**", "/course/**",
                    "/views/**", "/api/notices"
                ).permitAll()
                .requestMatchers("/adashboard", "/users", "/admin-add", "/updateusers", "/edituser",
                                 "/broadcast-email", "/broadcast-log").hasRole("ADMIN")
                .requestMatchers("/addnotice").hasAnyRole("ADMIN", "FACULTY")
                .requestMatchers("/fdashboard", "/f-assignments", "/f-create-assignment", "/f-grade").hasRole("FACULTY")
                .requestMatchers("/sdashboard", "/s-courses", "/s-assignments", "/s-start-course",
                                 "/s-premium", "/s-search", "/s-profile", "/s-submit", "/s-update-progress").hasRole("STUDENT")
                .anyRequest().authenticated()
            ).formLogin(form ->form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("email") // Since user_master uses email for login
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
                    // Custom logic logic uses roles like "student", "faculty", "admin"
                    .roles(user.getRole().toUpperCase())
                    .disabled(user.getStatus() == null || user.getStatus() != 1)
                    .build();
        };
    }

    @Bean
    public org.springframework.security.crypto.password.PasswordEncoder passwordEncoder() {
        // As from previous code, the passwords seem to be plain text.
        // Using NoOpPasswordEncoder for now so existing passwords work.
        return org.springframework.security.crypto.password.NoOpPasswordEncoder.getInstance();
    }
}
