package com.example.lms.controller;

import com.example.lms.contact.service.ContactService;
import com.example.lms.faq.service.FAQService;
import com.example.lms.home.controller.HomeController;
import com.example.lms.home.service.HomeService;
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

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class HomeControllerTest {

    @InjectMocks
    private HomeController controller;

    private MockMvc mockMvc;

    @Mock
    private ContactService contactService;

    @Mock
    private FAQService faqService;

    @Mock
    private HomeService homeService;

    @BeforeEach
    void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    void testIndexEndpoint() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/index"));
    }

    @Test
    void testAboutEndpoint() throws Exception {
        mockMvc.perform(get("/about"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/about"));
    }

    @Test
    void testContactGet() throws Exception {
        mockMvc.perform(get("/contact"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/contact"));
    }

    @Test
    void testContactPost() throws Exception {
        mockMvc.perform(post("/contact")
                        .param("name", "User")
                        .param("email", "test@test.com")
                        .param("mobile", "1234")
                        .param("subject", "Help")
                        .param("message", "Need assistance"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/contact"))
                .andExpect(model().attributeExists("sms"));
    }
}
