package com.example.lms.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.lms.model.Contact;
import com.example.lms.model.User;
import com.example.lms.repository.ContactRepository;
import com.example.lms.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class AnoController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ContactRepository contactRepository;

    @GetMapping("/test")
    public ModelAndView test() {
        List<String> li = new ArrayList<>();
        li.add("Abinash");
        li.add("Richa");
        li.add("Jubli");

        ModelAndView obj = new ModelAndView();
        obj.addObject("roll", 1234);
        obj.addObject("name", "Abinash");
        LocalDateTime now = LocalDateTime.now();
        obj.addObject("now", now);
        obj.addObject("data", li);
        obj.setViewName("test");
        return obj;
    }

    @PostMapping("/calclulate")
    public String calclulate_data(Model model, @RequestParam("btn") String btn, @RequestParam("num1") int num1,
            @RequestParam("num2") int num2) {
        System.out.println("Calculate Data Processed using POST method");
        int result = 0;
        if (btn.equals("add")) {
            result = num1 + num2;
        } else if (btn.equals("subtract")) {
            result = num1 - num2;
        } else if (btn.equals("multiply")) {
            result = num1 * num2;
        }
        model.addAttribute("result", result);
        return "calclulate";
    }

    @GetMapping("/calclulate")
    public String calclulate() {
        System.out.println("Calculate Data Processed using GET method");
        return "calclulate";
    }

    @GetMapping({"/", "/index"})
    public String index() {
        return "index";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }

    @PostMapping("/contact")
    public String contactSave(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message,
            Model model) {

        Contact c = new Contact();
        c.setName(name);
        c.setEmail(email);
        c.setMobile(mobile);
        c.setSubject(subject);
        c.setMessage(message);
        contactRepository.save(c);

        model.addAttribute("sms", "Contact saved successfully ");
        return "contact";
    }

    @GetMapping("/welcome")
    public String welcome() {
        return "welcome";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String login_chk(HttpSession session, @RequestParam("email") String email,
            @RequestParam("password") String password,
            Model model) {

        Optional<User> optUser = userRepository.findByEmailAndPassword(email, password);

        if (optUser.isPresent()) {
            User user = optUser.get();
            if (user.getStatus() != null && user.getStatus() == 1) {
                session.setAttribute("name", user.getName());
                session.setAttribute("email", user.getEmail());

                user.setIsOnline(1);
                userRepository.save(user);

                if ("Student".equalsIgnoreCase(user.getRole())) {
                    return "sdashboard";
                }
                if ("Faculty".equalsIgnoreCase(user.getRole())) {
                    return "fdashboard";
                }
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    return "adashboard";
                }
            } else {
                model.addAttribute("output", "Please contact your admin to active your account.");
            }
        } else {
            model.addAttribute("output", "Invalid email or password.");
        }
        System.out.println("chk login...");
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register")
    public String register_save(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            @RequestParam("role") String role,
            Model model) {

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setMobile(mobile);
        user.setPassword(password);
        user.setRole(role);
        user.setStatus(0);
        user.setIsOnline(0);
        userRepository.save(user);

        model.addAttribute("output", "Registration complete! Please wait for admin approval to login.");

        return "login";
    }

    @GetMapping("/faq")
    public String faq() {
        return "faq";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            Optional<User> uOpt = userRepository.findByEmail(email);
            if(uOpt.isPresent()) {
                User u = uOpt.get();
                u.setIsOnline(0);
                userRepository.save(u);
            }
        }
        session.invalidate();
        model.addAttribute("output", "You have successfully logged out.");
        return "login";
    }

}
