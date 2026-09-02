package com.example.lms.controller;

import com.example.lms.model.FAQ;
import com.example.lms.repository.FAQRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/faq")
public class AdminFAQController {

    @Autowired
    private FAQRepository faqRepository;

    @PostMapping("/save")
    public String saveFaq(@ModelAttribute FAQ faq, HttpSession session, RedirectAttributes redirectAttributes) {
        String role = (String) session.getAttribute("role");
        if (!"Admin".equalsIgnoreCase(role)) {
            return "redirect:/login";
        }

        faqRepository.save(faq);
        redirectAttributes.addFlashAttribute("message", "FAQ saved successfully!");
        return "redirect:/faq";
    }

    @PostMapping("/delete/{id}")
    public String deleteFaq(@PathVariable Integer id, HttpSession session, RedirectAttributes redirectAttributes) {
        String role = (String) session.getAttribute("role");
        if (!"Admin".equalsIgnoreCase(role)) {
            return "redirect:/login";
        }

        faqRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "FAQ deleted successfully!");
        return "redirect:/faq";
    }
}
