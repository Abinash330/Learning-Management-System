package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "email_broadcast_log")
public class BroadcastLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String subject;
    
    @Column(columnDefinition = "TEXT")
    private String message;
    
    private String audience;
    
    @Column(name = "recipient_count")
    private Integer recipientCount;
    
    @Column(name = "sent_at")
    private LocalDateTime sentAt;

    public BroadcastLog() {}
    public BroadcastLog(Integer id, String subject, String message, String audience, Integer recipientCount, LocalDateTime sentAt) {
        this.id = id;
        this.subject = subject;
        this.message = message;
        this.audience = audience;
        this.recipientCount = recipientCount;
        this.sentAt = sentAt;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getAudience() { return audience; }
    public void setAudience(String audience) { this.audience = audience; }
    public Integer getRecipientCount() { return recipientCount; }
    public void setRecipientCount(Integer recipientCount) { this.recipientCount = recipientCount; }
    public LocalDateTime getSentAt() { return sentAt; }
    public void setSentAt(LocalDateTime sentAt) { this.sentAt = sentAt; }
}
