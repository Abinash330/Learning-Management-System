package com.example.lms.controller;

import com.example.lms.model.AssignmentSubmission;
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

import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class FacultyControllerTest {
    @InjectMocks
    private FacultyController controller;

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
    private AssignmentRepository assignmentRepository;
    @Mock
    private SubmissionRepository submissionRepository;
    @Mock
    private NoticeRepository noticeRepository;

    @Test
    @WithMockUser(username = "faculty@test.com")
    void testFdashboard() throws Exception {
        User user = new User();
        user.setEmail("faculty@test.com");
        user.setName("Faculty User");
        when(userRepository.findByEmail("faculty@test.com")).thenReturn(Optional.of(user));
        when(courseRepository.findByInstructor(user)).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/fdashboard").principal(() -> "faculty@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("fdashboard"))
                .andExpect(model().attributeExists("name", "courseCount"));
    }

    @Test
    @WithMockUser(username = "faculty@test.com")
    void testFAssignments() throws Exception {
        User user = new User();
        user.setEmail("faculty@test.com");
        when(userRepository.findByEmail("faculty@test.com")).thenReturn(Optional.of(user));

        mockMvc.perform(get("/f-assignments").principal(() -> "faculty@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("f-assignments"));
    }

    @Test
    @WithMockUser(username = "faculty@test.com")
    void testGradeSubmission() throws Exception {
        AssignmentSubmission sub = new AssignmentSubmission();
        when(submissionRepository.findById(anyInt())).thenReturn(Optional.of(sub));

        mockMvc.perform(post("/f-grade")
                        .param("submission_id", "1")
                        .param("marks", "90")
                        .param("feedback", "Good"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/f-assignments"));
    }
}
