package com.example.lms.controller;

import com.example.lms.model.Assignment;
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

import java.util.Optional;

import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class StudentControllerTest {
    @InjectMocks
    private StudentController controller;

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
    private EnrollmentRepository enrollmentRepository;
    @Mock
    private AssignmentRepository assignmentRepository;
    @Mock
    private SubmissionRepository submissionRepository;
    @Mock
    private CourseRepository courseRepository;
    @Mock
    private NoticeRepository noticeRepository;

    @Test
    @WithMockUser(username = "student@test.com")
    void testSDashboard() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        user.setName("Student");
        when(userRepository.findByEmail("student@test.com")).thenReturn(Optional.of(user));

        mockMvc.perform(get("/sdashboard").principal(() -> "student@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("sdashboard"))
                .andExpect(model().attributeExists("name", "enrolledCount"));
    }

    @Test
    @WithMockUser(username = "student@test.com")
    void testSCourses() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        when(userRepository.findByEmail("student@test.com")).thenReturn(Optional.of(user));

        mockMvc.perform(get("/s-courses").principal(() -> "student@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("s-courses"));
    }

    @Test
    @WithMockUser(username = "student@test.com")
    void testSubmitAssignment() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        when(userRepository.findByEmail("student@test.com")).thenReturn(Optional.of(user));
        
        Assignment assignment = new Assignment();
        when(assignmentRepository.findById(anyInt())).thenReturn(Optional.of(assignment));

        mockMvc.perform(post("/s-submit").principal(() -> "student@test.com")
                        .param("assignment_id", "1")
                        .param("answer", "My answer"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/s-assignments"));
    }
}
