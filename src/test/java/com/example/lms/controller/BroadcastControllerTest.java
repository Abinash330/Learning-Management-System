package com.example.lms.controller;

import com.example.lms.notification.controller.BroadcastController;
import com.example.lms.notification.service.BroadcastService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.Collections;

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

    private MockMvc mockMvc;

    @Mock
    private BroadcastService broadcastService;

    @BeforeEach
    void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    void testBroadcastLog() throws Exception {
        when(broadcastService.getRecentBroadcastLogs()).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/broadcast-log"))
                .andExpect(status().isOk())
                .andExpect(view().name("admin/broadcast-log"))
                .andExpect(model().attributeExists("broadcastLogs"));
    }

    @Test
    void testBroadcastEmailSuccess() throws Exception {
        when(broadcastService.sendBroadcastEmail(anyString(), anyString(), anyString())).thenReturn(5);

        mockMvc.perform(post("/broadcast-email")
                        .param("subject", "Test Subject")
                        .param("message", "Test Message")
                        .param("audience", "students"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/adashboard"))
                .andExpect(flash().attributeExists("broadcastSuccess"));

        verify(broadcastService).sendBroadcastEmail("Test Subject", "Test Message", "students");
    }

    @Test
    void testBroadcastEmailNoRecipients() throws Exception {
        when(broadcastService.sendBroadcastEmail(anyString(), anyString(), anyString())).thenReturn(0);

        mockMvc.perform(post("/broadcast-email")
                        .param("subject", "Test Subject")
                        .param("message", "Test Message")
                        .param("audience", "students"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/adashboard"))
                .andExpect(flash().attributeExists("broadcastError"));
    }
}
