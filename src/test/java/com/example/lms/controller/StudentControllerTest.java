package com.example.lms.controller;

import com.example.lms.assignment.service.AssignmentService;
import com.example.lms.course.service.CourseService;
import com.example.lms.doubt.service.DoubtService;
import com.example.lms.enrollment.service.EnrollmentService;
import com.example.lms.exam.service.ExamService;
import com.example.lms.notice.service.NoticeService;
import com.example.lms.student.controller.StudentController;
import com.example.lms.student.dto.StudentDashboardDTO;
import com.example.lms.student.service.StudentService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import com.example.lms.video.service.VideoService;
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
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class StudentControllerTest {

    @InjectMocks
    private StudentController controller;

    private MockMvc mockMvc;

    @Mock
    private UserService userService;
    @Mock
    private CourseService courseService;
    @Mock
    private EnrollmentService enrollmentService;
    @Mock
    private AssignmentService assignmentService;
    @Mock
    private ExamService examService;
    @Mock
    private NoticeService noticeService;
    @Mock
    private VideoService videoService;
    @Mock
    private DoubtService doubtService;
    @Mock
    private StudentService studentService;

    @BeforeEach
    void setup() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        mockMvc = MockMvcBuilders.standaloneSetup(controller).setViewResolvers(viewResolver).build();
    }

    @Test
    @WithMockUser(username = "student@test.com")
    void testSDashboard() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        user.setName("Student");
        when(userService.getUserByEmail("student@test.com")).thenReturn(Optional.of(user));

        StudentDashboardDTO dto = new StudentDashboardDTO();
        dto.setStudentName("Student");
        dto.setEnrolledCount(1);
        when(studentService.getStudentDashboard(user)).thenReturn(dto);

        mockMvc.perform(get("/sdashboard").principal(() -> "student@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("student/dashboard"))
                .andExpect(model().attributeExists("name", "enrolledCount"));
    }

    @Test
    @WithMockUser(username = "student@test.com")
    void testSCourses() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        when(userService.getUserByEmail("student@test.com")).thenReturn(Optional.of(user));
        when(enrollmentService.getEnrollmentsByStudent(user)).thenReturn(Collections.emptyList());

        mockMvc.perform(get("/s-courses").principal(() -> "student@test.com"))
                .andExpect(status().isOk())
                .andExpect(view().name("student/courses"));
    }

    @Test
    @WithMockUser(username = "student@test.com")
    void testSubmitAssignment() throws Exception {
        User user = new User();
        user.setEmail("student@test.com");
        when(userService.getUserByEmail("student@test.com")).thenReturn(Optional.of(user));

        mockMvc.perform(post("/s-submit").principal(() -> "student@test.com")
                        .param("assignment_id", "1")
                        .param("answer", "My answer"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/s-assignments"));

        verify(assignmentService).submitAssignment(1, "My answer", user);
    }
}
