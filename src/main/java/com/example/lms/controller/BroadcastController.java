package com.example.lms.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.lms.model.BroadcastLog;
import com.example.lms.model.User;
import com.example.lms.repository.BroadcastLogRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.service.EmailService;

@Controller
public class BroadcastController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BroadcastLogRepository broadcastLogRepository;

    @Autowired
    private EmailService emailService;

    @PostMapping("/broadcast-email")
    public String broadcastEmail(
            @RequestParam("subject")  String subject,
            @RequestParam("message")  String message,
            @RequestParam("audience") String audience,
            RedirectAttributes redir) {

        String audienceLabel;
        List<User> targetUsers;
        
        switch (audience) {
            case "students" -> { targetUsers = userRepository.findByRoleAndStatus("Student", 1); audienceLabel = "All Students"; }
            case "faculty"  -> { targetUsers = userRepository.findByRoleAndStatus("Faculty", 1); audienceLabel = "All Faculty"; }
            case "admins"   -> { targetUsers = userRepository.findByRoleAndStatus("Admin", 1);   audienceLabel = "All Admins"; }
            default         -> { targetUsers = userRepository.findByStatus(1);                     audienceLabel = "All Users"; }
        }

        List<String> recipients = targetUsers.stream().map(User::getEmail).collect(Collectors.toList());

        if (recipients.isEmpty()) {
            redir.addFlashAttribute("broadcastError", "No active recipients found for audience: " + audienceLabel);
            return "redirect:/adashboard";
        }

        // Build HTML email body
        String htmlBody = emailService.buildEmailTemplate(subject, message, audienceLabel);

        // Send emails asynchronously
        emailService.broadcastEmail(recipients, subject, htmlBody);

        // Log this broadcast to DB
        try {
            BroadcastLog log = new BroadcastLog();
            log.setSubject(subject);
            log.setMessage(message);
            log.setAudience(audienceLabel);
            log.setRecipientCount(recipients.size());
            log.setSentAt(LocalDateTime.now());
            broadcastLogRepository.save(log);
        } catch (Exception e) {
            System.err.println("Could not log broadcast: " + e.getMessage());
        }

        redir.addFlashAttribute("broadcastSuccess",
                "📢 Broadcast sent to " + recipients.size() + " user(s) in <strong>" + audienceLabel + "</strong>!");
        return "redirect:/adashboard";
    }

    @GetMapping("/broadcast-log")
    public String broadcastLog(Model model) {
        try {
            model.addAttribute("broadcastLogs", broadcastLogRepository.findTop50ByOrderBySentAtDesc());
        } catch (Exception e) {
            model.addAttribute("broadcastLogs", java.util.Collections.emptyList());
            model.addAttribute("logError", "Broadcast log table not found. Run the SQL migration first.");
        }
        return "broadcast-log";
    }
}
