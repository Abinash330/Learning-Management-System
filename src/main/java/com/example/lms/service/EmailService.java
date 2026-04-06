package com.example.lms.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import jakarta.mail.internet.MimeMessage;

/**
 * EmailService — sends HTML broadcast emails to LMS users.
 * Runs asynchronously so the HTTP response returns immediately.
 */
@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    /**
     * Send an HTML email to a single recipient.
     */
    @Async
    public void sendHtmlEmail(String toEmail, String subject, String htmlBody) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(toEmail);
            helper.setSubject(subject);
            helper.setText(htmlBody, true); // true = HTML
            helper.setFrom("abinashkar019@gmail.com", "EduPro LMS Admin");
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send email to " + toEmail + ": " + e.getMessage());
        }
    }

    /**
     * Broadcast to a list of recipients.
     */
    @Async
    public void broadcastEmail(List<String> recipients, String subject, String htmlBody) {
        for (String email : recipients) {
            sendHtmlEmail(email, subject, htmlBody);
        }
    }

    /**
     * Build a beautiful HTML email template.
     */
    public String buildEmailTemplate(String title, String message, String targetLabel) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
            </head>
            <body style="margin:0;padding:0;background:#f1f5f9;font-family:'Segoe UI',Arial,sans-serif;">
              <table width="100%%" cellpadding="0" cellspacing="0" style="background:#f1f5f9;padding:40px 20px;">
                <tr><td align="center">
                  <table width="600" cellpadding="0" cellspacing="0" style="max-width:600px;width:100%%;">
            
                    <!-- Header -->
                    <tr>
                      <td style="background:linear-gradient(135deg,#0f172a,#1e1b4b,#312e81);border-radius:16px 16px 0 0;padding:40px 40px 30px;text-align:center;">
                        <div style="background:rgba(255,255,255,0.1);border-radius:50%%;width:64px;height:64px;display:inline-flex;align-items:center;justify-content:center;margin-bottom:16px;">
                          <span style="font-size:1.8rem;">📢</span>
                        </div>
                        <h1 style="margin:0;color:#ffffff;font-size:1.6rem;font-weight:800;letter-spacing:-0.5px;">EduPro LMS</h1>
                        <p style="margin:8px 0 0;color:rgba(255,255,255,0.65);font-size:0.85rem;font-weight:500;">
                          Broadcast to: <strong style="color:#a5b4fc;">%s</strong>
                        </p>
                      </td>
                    </tr>
            
                    <!-- Body -->
                    <tr>
                      <td style="background:#ffffff;padding:40px;">
                        <h2 style="margin:0 0 16px;color:#0f172a;font-size:1.3rem;font-weight:700;">%s</h2>
                        <div style="color:#475569;font-size:0.95rem;line-height:1.75;white-space:pre-wrap;">%s</div>
                        
                        <div style="margin-top:32px;padding:20px;background:#f8fafc;border-radius:12px;border-left:4px solid #4f46e5;">
                          <p style="margin:0;color:#64748b;font-size:0.82rem;">
                            This message was sent from the <strong>EduPro LMS Admin Portal</strong>. 
                            If you believe this was sent in error, please contact support.
                          </p>
                        </div>
                      </td>
                    </tr>
            
                    <!-- Footer -->
                    <tr>
                      <td style="background:#f8fafc;border-radius:0 0 16px 16px;padding:24px 40px;text-align:center;border-top:1px solid #e2e8f0;">
                        <p style="margin:0;color:#94a3b8;font-size:0.78rem;">
                          © 2026 EduPro LMS &nbsp;|&nbsp; 
                          <a href="#" style="color:#6366f1;text-decoration:none;">Visit Portal</a>
                        </p>
                      </td>
                    </tr>
            
                  </table>
                </td></tr>
              </table>
            </body>
            </html>
            """.formatted(targetLabel, title, message);
    }
}
