package com.example.lms.service;

import jakarta.mail.internet.MimeMessage;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mail.javamail.JavaMailSender;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class EmailServiceTest {

    @Mock
    private JavaMailSender mailSender;

    @InjectMocks
    private EmailService emailService;

    @Mock
    private MimeMessage mimeMessage;

    @BeforeEach
    void setUp() {
        // leniency for tests that don't call mailSender
    }

    @Test
    void shouldSendHtmlEmail() {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        emailService.sendHtmlEmail("test@test.com", "Subject", "<h1>Body</h1>");

        verify(mailSender, times(1)).createMimeMessage();
        verify(mailSender, times(1)).send(mimeMessage);
    }

    @Test
    void shouldBroadcastEmail() {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        List<String> emails = Arrays.asList("test1@test.com", "test2@test.com");
        emailService.broadcastEmail(emails, "Subject", "<h1>Body</h1>");

        verify(mailSender, times(2)).createMimeMessage();
        verify(mailSender, times(2)).send(mimeMessage);
    }

    @Test
    void shouldBuildEmailTemplate() {
        String template = emailService.buildEmailTemplate("Test Title", "Test Message", "All Students");
        
        assertThat(template).contains("Test Title");
        assertThat(template).contains("Test Message");
        assertThat(template).contains("All Students");
        assertThat(template).contains("<!DOCTYPE html>");
    }
}
