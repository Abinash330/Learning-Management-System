package com.example.lms.home.controller;

import com.example.lms.contact.model.Contact;
import com.example.lms.contact.service.ContactService;
import com.example.lms.faq.model.FAQ;
import com.example.lms.faq.service.FAQService;
import com.example.lms.home.service.HomeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    private final ContactService contactService;
    private final FAQService faqService;
    private final HomeService homeService;

    @Autowired
    public HomeController(ContactService contactService,
                          FAQService faqService,
                          HomeService homeService) {
        this.contactService = contactService;
        this.faqService = faqService;
        this.homeService = homeService;
    }

    @GetMapping({"/", "/index", "/home"})
    public String index() {
        return "home/index";
    }

    @GetMapping("/about")
    public String about() {
        return "home/about";
    }

    @GetMapping("/contact")
    public String contact() {
        return "home/contact";
    }

    @PostMapping("/contact")
    public String contactSave(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message,
            Model model) {

        contactService.saveContact(name, email, mobile, subject, message);
        model.addAttribute("sms", "Contact saved successfully ");
        return "home/contact";
    }

    @GetMapping("/faq")
    public String faq(HttpSession session, Model model) {
        String userRole = (String) session.getAttribute("role");
        List<FAQ> faqs = faqService.getFAQsForRole(userRole);
        model.addAttribute("faqs", faqs);
        return "home/faq";
    }

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
        obj.setViewName("home/test");
        return obj;
    }

    @PostMapping("/calclulate")
    public String calculateData(Model model,
                                @RequestParam("btn") String btn,
                                @RequestParam("num1") int num1,
                                @RequestParam("num2") int num2) {
        int result = homeService.calculate(btn, num1, num2);
        model.addAttribute("result", result);
        return "home/calclulate";
    }

    @GetMapping("/calclulate")
    public String calculate() {
        return "home/calclulate";
    }
}
