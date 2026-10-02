package com.example.lms.faq.controller;

import com.example.lms.faq.model.FAQ;
import com.example.lms.faq.service.FAQService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/faq")
public class AdminFAQController {

    private final FAQService faqService;

    @Autowired
    public AdminFAQController(FAQService faqService) {
        this.faqService = faqService;
    }

    @PostMapping("/save")
    public String saveFaq(@ModelAttribute FAQ faq, HttpSession session, RedirectAttributes redirectAttributes) {
        String role = (String) session.getAttribute("role");
        if (!"Admin".equalsIgnoreCase(role)) {
            return "redirect:/login";
        }

        faqService.saveFAQ(faq);
        redirectAttributes.addFlashAttribute("message", "FAQ saved successfully!");
        return "redirect:/faq";
    }

    @PostMapping("/delete/{id}")
    public String deleteFaq(@PathVariable Integer id, HttpSession session, RedirectAttributes redirectAttributes) {
        String role = (String) session.getAttribute("role");
        if (!"Admin".equalsIgnoreCase(role)) {
            return "redirect:/login";
        }

        faqService.deleteFAQ(id);
        redirectAttributes.addFlashAttribute("message", "FAQ deleted successfully!");
        return "redirect:/faq";
    }
}
