package com.example.lms;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.beans.factory.annotation.Autowired;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private org.springframework.jdbc.core.JdbcTemplate jdbc;

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
                .requestMatchers("/adashboard", "/users", "/addnotice", "/admin-add", "/updateusers", "/edituser").hasRole("ADMIN")
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
            // Store session attributes and mark online just like AnoController
            java.util.List<java.util.Map<String, Object>> users = jdbc.queryForList("SELECT name, email FROM user_master WHERE email = ?", email);
            if (!users.isEmpty()) {
                request.getSession().setAttribute("name", users.get(0).get("name"));
                request.getSession().setAttribute("email", users.get(0).get("email"));
            }
            jdbc.execute("UPDATE user_master SET is_online=1 WHERE email='" + email + "'");

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
            String sql = "SELECT email, password, role, status FROM user_master WHERE email = ?";
            java.util.List<java.util.Map<String, Object>> users = jdbc.queryForList(sql, username);
            if (users.isEmpty()) {
                throw new org.springframework.security.core.userdetails.UsernameNotFoundException("User not found");
            }
            java.util.Map<String, Object> user = users.get(0);
            return org.springframework.security.core.userdetails.User
                    .withUsername((String) user.get("email"))
                    .password((String) user.get("password"))
                    // Custom logic logic uses roles like "student", "faculty", "admin"
                    .roles(((String) user.get("role")).toUpperCase())
                    .disabled(!"1".equals(String.valueOf(user.get("status"))))
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
