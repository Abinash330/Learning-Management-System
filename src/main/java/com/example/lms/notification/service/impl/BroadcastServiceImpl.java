package com.example.lms.notification.service.impl;

import com.example.lms.notification.model.BroadcastLog;
import com.example.lms.notification.repository.BroadcastLogRepository;
import com.example.lms.notification.service.BroadcastService;
import com.example.lms.notification.service.EmailService;
import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class BroadcastServiceImpl implements BroadcastService {

    private final UserRepository userRepository;
    private final BroadcastLogRepository broadcastLogRepository;
    private final EmailService emailService;

    @Autowired
    public BroadcastServiceImpl(UserRepository userRepository,
                                BroadcastLogRepository broadcastLogRepository,
                                EmailService emailService) {
        this.userRepository = userRepository;
        this.broadcastLogRepository = broadcastLogRepository;
        this.emailService = emailService;
    }

    @Override
    public int sendBroadcastEmail(String subject, String message, String audience) {
        String audienceLabel;
        List<User> targetUsers;
        
        switch (audience != null ? audience.toLowerCase() : "") {
            case "students" -> { targetUsers = userRepository.findByRoleAndStatus("Student", 1); audienceLabel = "All Students"; }
            case "faculty"  -> { targetUsers = userRepository.findByRoleAndStatus("Faculty", 1); audienceLabel = "All Faculty"; }
            case "admins"   -> { targetUsers = userRepository.findByRoleAndStatus("Admin", 1);   audienceLabel = "All Admins"; }
            default         -> { targetUsers = userRepository.findByStatus(1);                     audienceLabel = "All Users"; }
        }

        List<String> recipients = targetUsers.stream().map(User::getEmail).collect(Collectors.toList());

        if (recipients.isEmpty()) {
            return 0;
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

        return recipients.size();
    }

    @Override
    @Transactional(readOnly = true)
    public List<BroadcastLog> getRecentBroadcastLogs() {
        try {
            return broadcastLogRepository.findTop50ByOrderBySentAtDesc();
        } catch (Exception e) {
            return Collections.emptyList();
        }
    }
}
