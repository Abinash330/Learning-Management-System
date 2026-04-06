package com.example.lms.controller;

import com.example.lms.model.User;
import com.example.lms.repository.ContactRepository;
import com.example.lms.repository.UserRepository;
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

import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class AnoControllerTest {
    @InjectMocks
    private AnoController controller;

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
    private ContactRepository contactRepository;

    @Test
    void testIndexEndpoint() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("index"));
    }

    @Test
    void testLoginGet() throws Exception {
        mockMvc.perform(get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"));
    }

    @Test
    void testLoginPostSuccess() throws Exception {
        User user = new User();
        user.setEmail("test@test.com");
        user.setPassword("pass");
        user.setName("Test User");
        user.setRole("Student");
        user.setStatus(1);

        when(userRepository.findByEmailAndPassword(anyString(), anyString())).thenReturn(Optional.of(user));

        mockMvc.perform(post("/login")
                        .param("email", "test@test.com")
                        .param("password", "pass"))
                .andExpect(status().isOk())
                .andExpect(view().name("sdashboard"))
                .andExpect(request().sessionAttribute("name", "Test User"));
    }

    @Test
    void testLoginPostFailure() throws Exception {
        when(userRepository.findByEmailAndPassword(anyString(), anyString())).thenReturn(Optional.empty());

        mockMvc.perform(post("/login")
                        .param("email", "wrong@test.com")
                        .param("password", "wrong"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"))
                .andExpect(model().attributeExists("output"));
    }

    @Test
    void testRegisterPost() throws Exception {
        mockMvc.perform(post("/register")
                        .param("name", "New User")
                        .param("email", "new@test.com")
                        .param("mobile", "1234567890")
                        .param("password", "pass")
                        .param("role", "Student"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"))
                .andExpect(model().attributeExists("output"));
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
                .andExpect(view().name("contact"))
                .andExpect(model().attributeExists("sms"));
    }

    @Test
    void testLogout() throws Exception {
        mockMvc.perform(get("/logout").sessionAttr("email", "test@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"));
    }
}
