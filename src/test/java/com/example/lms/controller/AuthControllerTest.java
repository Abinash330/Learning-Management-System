package com.example.lms.controller;

import com.example.lms.auth.controller.AuthController;
import com.example.lms.auth.service.AuthService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
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

import java.util.Optional;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class AuthControllerTest {

    @InjectMocks
    private AuthController controller;

    private MockMvc mockMvc;

    @Mock
    private AuthService authService;

    @Mock
    private UserService userService;

    @BeforeEach
    void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    void testLoginGet() throws Exception {
        mockMvc.perform(get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/login"));
    }

    @Test
    void testLoginPostSuccess() throws Exception {
        User user = new User();
        user.setEmail("test@test.com");
        user.setPassword("pass");
        user.setName("Test User");
        user.setRole("Student");
        user.setStatus(1);

        when(userService.authenticate("test@test.com", "pass")).thenReturn(Optional.of(user));

        mockMvc.perform(post("/login")
                        .param("email", "test@test.com")
                        .param("password", "pass"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/sdashboard"))
                .andExpect(request().sessionAttribute("name", "Test User"));
    }

    @Test
    void testLoginPostFailure() throws Exception {
        when(userService.authenticate(anyString(), anyString())).thenReturn(Optional.empty());

        mockMvc.perform(post("/login")
                        .param("email", "wrong@test.com")
                        .param("password", "wrong"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/login"))
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
                .andExpect(view().name("auth/login"))
                .andExpect(model().attributeExists("output"));
    }

    @Test
    void testLogout() throws Exception {
        mockMvc.perform(get("/logout").sessionAttr("email", "test@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/login"));
    }
}
