package com.example.lms.faculty.controller;

import com.example.lms.assignment.model.Assignment;
import com.example.lms.assignment.model.AssignmentSubmission;
import com.example.lms.assignment.service.AssignmentService;
import com.example.lms.course.model.Course;
import com.example.lms.course.service.CourseService;
import com.example.lms.faculty.dto.FacultyDashboardDTO;
import com.example.lms.faculty.service.FacultyService;
import com.example.lms.notice.service.NoticeService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class FacultyController {

    private final UserService userService;
    private final CourseService courseService;
    private final AssignmentService assignmentService;
    private final NoticeService noticeService;
    private final FacultyService facultyService;

    @Autowired
    public FacultyController(UserService userService,
                             CourseService courseService,
                             AssignmentService assignmentService,
                             NoticeService noticeService,
                             FacultyService facultyService) {
        this.userService = userService;
        this.courseService = courseService;
        this.assignmentService = assignmentService;
        this.noticeService = noticeService;
        this.facultyService = facultyService;
    }

    @GetMapping("/fdashboard")
    public String fdashboard(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> fOpt = userService.getUserByEmail(principal.getName());
            if (fOpt.isPresent()) {
                User faculty = fOpt.get();
                FacultyDashboardDTO dto = facultyService.getFacultyDashboard(faculty);
                model.addAttribute("name", dto.getFacultyName());
                model.addAttribute("courses", dto.getCourses());
                model.addAttribute("courseCount", dto.getCourseCount());
                model.addAttribute("totalStudents", dto.getTotalStudents());
                model.addAttribute("pendingGrade", dto.getPendingGrade());
                model.addAttribute("assignmentCount", dto.getAssignmentCount());
            }
        }
        return "faculty/dashboard";
    }

    @GetMapping("/f-assignments")
    public String fassignments(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> fOpt = userService.getUserByEmail(principal.getName());
            if (fOpt.isPresent()) {
                User faculty = fOpt.get();
                
                List<Course> myCourses = courseService.getCoursesByInstructor(faculty);
                model.addAttribute("myCourses", myCourses);

                List<Assignment> assignments = new ArrayList<>();
                List<AssignmentSubmission> pendingSubmissions = new ArrayList<>();
                
                for (Course c : myCourses) {
                    List<Assignment> assigns = assignmentService.getAssignmentsByCourseOrderByCreatedAtDesc(c);
                    assignments.addAll(assigns);
                    
                    for (Assignment a : assigns) {
                        List<AssignmentSubmission> subs = assignmentService.getSubmissionsByAssignment(a);
                        pendingSubmissions.addAll(subs.stream()
                                .filter(s -> "submitted".equals(s.getStatus()))
                                .collect(Collectors.toList()));
                    }
                }
                
                assignments.sort((a, b) -> {
                    if (a.getCreatedAt() != null && b.getCreatedAt() != null)
                        return b.getCreatedAt().compareTo(a.getCreatedAt());
                    return 0;
                });
                
                model.addAttribute("assignments", assignments);
                model.addAttribute("pendingSubmissions", pendingSubmissions);
            }
        }
        return "faculty/assignments";
    }

    @PostMapping("/f-create-assignment")
    public String createAssignment(
            @RequestParam("course_id") int courseId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("due_date") String dueDate,
            Principal principal) {
        if (principal != null) {
            Optional<User> fOpt = userService.getUserByEmail(principal.getName());
            if (fOpt.isPresent()) {
                assignmentService.createAssignment(courseId, title, description, dueDate, fOpt.get());
            }
        }
        return "redirect:/f-assignments";
    }

    @PostMapping("/f-grade")
    public String gradeSubmission(
            @RequestParam("submission_id") int submissionId,
            @RequestParam("marks") int marks,
            @RequestParam("feedback") String feedback) {
        assignmentService.gradeSubmission(submissionId, marks, feedback);
        return "redirect:/f-assignments";
    }

    @GetMapping("/faculty-notices")
    public String facultyNotices(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User faculty = uOpt.get();
                model.addAttribute("myNotices", noticeService.getNoticesByAudience(List.of("ALL", "FACULTY")));
                model.addAttribute("createdNotices", noticeService.getNoticesByCreatedBy(faculty));
            }
        }
        return "faculty/notices";
    }

    @PostMapping("/faculty-notices/add")
    public String facultyNoticesAdd(
            @RequestParam("title") String title, 
            @RequestParam("description") String description,
            @RequestParam(value = "file", required = false) MultipartFile file,
            Principal principal) {
            
        User faculty = (principal != null) ? userService.getUserByEmail(principal.getName()).orElse(null) : null;
        noticeService.createNotice(title, description, "STUDENT", file, faculty);
        return "redirect:/faculty-notices";
    }

    @PostMapping("/faculty-notices/delete")
    public String facultyNoticesDelete(@RequestParam("id") Long id, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            uOpt.ifPresent(user -> noticeService.deleteNoticeByIdAndUser(id, user));
        }
        return "redirect:/faculty-notices";
    }
}
