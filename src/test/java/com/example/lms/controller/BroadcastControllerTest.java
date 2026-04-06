package com.example.lms.controller;

import com.example.lms.model.User;
import com.example.lms.repository.BroadcastLogRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.service.EmailService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.BeforeEach;

import java.util.Collections;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class BroadcastControllerTest {
    @InjectMocks
    private BroadcastController controller;

    @BeforeEach
    void setup() {
                InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }


    private MockMvc mockMvc;

    @Mock
    private UserRepository userRepository;

    @Mock
    private BroadcastLogRepository broadcastLogRepository;

    @Mock
    private EmailService emailService;

    @Test
    void testBroadcastLog() throws Exception {
        when(broadcastLogRepository.findTop50ByOrderBySentAtDesc()).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/broadcast-log"))
                .andExpect(status().isOk())
                .andExpect(view().name("broadcast-log"))
                .andExpect(model().attributeExists("broadcastLogs"));
    }

    @Test
    void testBroadcastEmailSuccess() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        when(userRepository.findByRoleAndStatus("Student", 1)).thenReturn(List.of(user));
        when(emailService.buildEmailTemplate(anyString(), anyString(), anyString())).thenReturn("<html></html>");

        mockMvc.perform(post("/broadcast-email")
                        .param("subject", "Test Subject")
                        .param("message", "Test Message")
                        .param("audience", "students"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/adashboard"))
                .andExpect(flash().attributeExists("broadcastSuccess"));

        verify(emailService).broadcastEmail(any(), anyString(), anyString());
        verify(broadcastLogRepository).save(any());
    }

    @Test
    void testBroadcastEmailNoRecipients() throws Exception {
        when(userRepository.findByRoleAndStatus("Student", 1)).thenReturn(Collections.emptyList());

        mockMvc.perform(post("/broadcast-email")
                        .param("subject", "Test Subject")
                        .param("message", "Test Message")
                        .param("audience", "students"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/adashboard"))
                .andExpect(flash().attributeExists("broadcastError"));
    }
}
