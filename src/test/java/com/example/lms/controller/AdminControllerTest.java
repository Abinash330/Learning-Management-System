package com.example.lms.controller;

import com.example.lms.model.User;
import com.example.lms.repository.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.test.context.support.WithMockUser;
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
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class AdminControllerTest {
    @InjectMocks
    private AdminController controller;

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
    private CourseRepository courseRepository;
    @Mock
    private EnrollmentRepository enrollmentRepository;
    @Mock
    private NoticeRepository noticeRepository;
    @Mock
    private ContactRepository contactRepository;

    @Test
    @WithMockUser
    void testAdashboard() throws Exception {
        when(userRepository.findAll(any(org.springframework.data.domain.Sort.class))).thenReturn(Collections.emptyList());
        when(userRepository.count()).thenReturn(10L);

        mockMvc.perform(get("/adashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("adashboard"))
                .andExpect(model().attributeExists("users_master", "totalUsers"));
    }

    @Test
    @WithMockUser
    void testAdashboardManage() throws Exception {
        User user = new User();
        user.setEmail("test@test.com");
        when(userRepository.findByEmail(anyString())).thenReturn(Optional.of(user));

        mockMvc.perform(post("/adashboard")
                        .param("btn", "activate")
                        .param("email", "test@test.com"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/adashboard"));
    }

    @Test
    @WithMockUser
    void testAdminAddPost() throws Exception {
        mockMvc.perform(post("/admin-add")
                        .param("name", "Test")
                        .param("email", "test@test.com")
                        .param("role", "Student")
                        .param("mobile", "123")
                        .param("password", "pass"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/adashboard"));
    }
}
