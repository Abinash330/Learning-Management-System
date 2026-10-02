package com.example.lms.notification.controller;

import com.example.lms.notification.service.BroadcastService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class BroadcastController {

    private final BroadcastService broadcastService;

    @Autowired
    public BroadcastController(BroadcastService broadcastService) {
        this.broadcastService = broadcastService;
    }

    @PostMapping("/broadcast-email")
    public String broadcastEmail(
            @RequestParam("subject")  String subject,
            @RequestParam("message")  String message,
            @RequestParam("audience") String audience,
            RedirectAttributes redir) {

        int count = broadcastService.sendBroadcastEmail(subject, message, audience);

        if (count == 0) {
            redir.addFlashAttribute("broadcastError", "No active recipients found for audience: " + audience);
            return "redirect:/adashboard";
        }

        redir.addFlashAttribute("broadcastSuccess",
                "📢 Broadcast sent to " + count + " user(s) in <strong>" + audience + "</strong>!");
        return "redirect:/adashboard";
    }

    @GetMapping("/broadcast-log")
    public String broadcastLog(Model model) {
        model.addAttribute("broadcastLogs", broadcastService.getRecentBroadcastLogs());
        return "admin/broadcast-log";
    }
}
