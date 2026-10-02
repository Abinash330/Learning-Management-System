package com.example.lms.controller;

import com.example.lms.admin.controller.AdminController;
import com.example.lms.admin.dto.AdminDashboardDTO;
import com.example.lms.admin.service.AdminService;
import com.example.lms.course.service.CourseService;
import com.example.lms.enrollment.service.EnrollmentService;
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
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.Collections;
import java.util.Optional;

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

    private MockMvc mockMvc;

    @Mock
    private AdminService adminService;
    @Mock
    private UserService userService;
    @Mock
    private CourseService courseService;
    @Mock
    private EnrollmentService enrollmentService;

    @BeforeEach
    void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    @WithMockUser
    void testAdashboard() throws Exception {
        AdminDashboardDTO dto = new AdminDashboardDTO();
        dto.setUsersMaster(Collections.emptyList());
        dto.setTotalUsers(10L);
        when(adminService.getDashboardData()).thenReturn(dto);

        mockMvc.perform(get("/adashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("admin/dashboard"))
                .andExpect(model().attributeExists("users_master", "totalUsers"));
    }

    @Test
    @WithMockUser
    void testAdashboardManage() throws Exception {
        User user = new User();
        user.setEmail("test@test.com");
        when(userService.getUserByEmail(anyString())).thenReturn(Optional.of(user));

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
