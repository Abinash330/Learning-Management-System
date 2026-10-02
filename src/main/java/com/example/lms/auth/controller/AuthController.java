package com.example.lms.auth.controller;

import com.example.lms.auth.dto.RegisterRequestDTO;
import com.example.lms.auth.service.AuthService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class AuthController {

    private final AuthService authService;
    private final UserService userService;

    @Autowired
    public AuthController(AuthService authService, UserService userService) {
        this.authService = authService;
        this.userService = userService;
    }

    @GetMapping("/login")
    public String login() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String loginCheck(HttpSession session,
                             @RequestParam("email") String email,
                             @RequestParam("password") String password,
                             Model model) {

        Optional<User> optUser = userService.authenticate(email, password);

        if (optUser.isPresent()) {
            User user = optUser.get();
            if (user.getStatus() != null && user.getStatus() == 1) {
                session.setAttribute("name", user.getName());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("role", user.getRole());

                userService.setUserOnlineStatus(user.getEmail(), 1);

                if ("Student".equalsIgnoreCase(user.getRole())) {
                    return "redirect:/sdashboard";
                }
                if ("Faculty".equalsIgnoreCase(user.getRole())) {
                    return "redirect:/fdashboard";
                }
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    return "redirect:/adashboard";
                }
            } else {
                model.addAttribute("output", "Please contact your admin to activate your account.");
            }
        } else {
            model.addAttribute("output", "Invalid email or password.");
        }
        return "auth/login";
    }

    @GetMapping("/register")
    public String register() {
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerSave(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            @RequestParam("role") String role,
            Model model) {

        RegisterRequestDTO dto = new RegisterRequestDTO(name, email, mobile, password, role);
        authService.register(dto);

        model.addAttribute("output", "Registration complete! Please wait for admin approval to login.");
        return "auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            authService.logout(email);
        }
        session.invalidate();
        model.addAttribute("output", "You have successfully logged out.");
        return "auth/login";
    }
}
