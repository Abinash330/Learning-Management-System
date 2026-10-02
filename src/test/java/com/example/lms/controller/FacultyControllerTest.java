package com.example.lms.controller;

import com.example.lms.assignment.service.AssignmentService;
import com.example.lms.course.service.CourseService;
import com.example.lms.faculty.controller.FacultyController;
import com.example.lms.faculty.dto.FacultyDashboardDTO;
import com.example.lms.faculty.service.FacultyService;
import com.example.lms.notice.service.NoticeService;
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

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class FacultyControllerTest {

    @InjectMocks
    private FacultyController controller;

    private MockMvc mockMvc;

    @Mock
    private UserService userService;
    @Mock
    private CourseService courseService;
    @Mock
    private AssignmentService assignmentService;
    @Mock
    private NoticeService noticeService;
    @Mock
    private FacultyService facultyService;

    @BeforeEach
    void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    @WithMockUser(username = "faculty@test.com")
    void testFdashboard() throws Exception {
        User user = new User();
        user.setEmail("faculty@test.com");
        user.setName("Faculty User");
        when(userService.getUserByEmail("faculty@test.com")).thenReturn(Optional.of(user));

        FacultyDashboardDTO dto = new FacultyDashboardDTO();
        dto.setFacultyName("Faculty User");
        dto.setCourseCount(0);
        dto.setCourses(Collections.emptyList());
        when(facultyService.getFacultyDashboard(user)).thenReturn(dto);

        mockMvc.perform(get("/fdashboard").principal(() -> "faculty@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("faculty/dashboard"))
                .andExpect(model().attributeExists("name", "courseCount"));
    }

    @Test
    @WithMockUser(username = "faculty@test.com")
    void testFAssignments() throws Exception {
        User user = new User();
        user.setEmail("faculty@test.com");
        when(userService.getUserByEmail("faculty@test.com")).thenReturn(Optional.of(user));
        when(courseService.getCoursesByInstructor(user)).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/f-assignments").principal(() -> "faculty@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("faculty/assignments"));
    }

    @Test
    @WithMockUser(username = "faculty@test.com")
    void testGradeSubmission() throws Exception {
        mockMvc.perform(post("/f-grade")
                        .param("submission_id", "1")
                        .param("marks", "90")
                        .param("feedback", "Good"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/f-assignments"));

        verify(assignmentService).gradeSubmission(1, 90, "Good");
    }
}
