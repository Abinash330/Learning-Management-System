package com.example.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import com.example.lms.model.AssignmentSubmission;
import com.example.lms.model.Course;
import com.example.lms.model.Notice;
import com.example.lms.model.User;
import com.example.lms.repository.AssignmentRepository;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.EnrollmentRepository;
import com.example.lms.repository.NoticeRepository;
import com.example.lms.repository.SubmissionRepository;
import com.example.lms.repository.UserRepository;

@Controller
public class FacultyController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private AssignmentRepository assignmentRepository;
    @Autowired
    private SubmissionRepository submissionRepository;
    @Autowired
    private NoticeRepository noticeRepository;

    @GetMapping("/fdashboard")
    public String fdashboard(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> fOpt = userRepository.findByEmail(principal.getName());
            if(fOpt.isPresent()) {
                User faculty = fOpt.get();
                model.addAttribute("name", faculty.getName());
                
                List<Course> courses = courseRepository.findByInstructor(faculty);
                model.addAttribute("courses", courses);
                model.addAttribute("courseCount", courses.size());

                long totalStudents = 0;
                long pendingGrade = 0;
                long assignmentCount = 0;

                for(Course c : courses) {
                    totalStudents += enrollmentRepository.countByCourse(c);
                    List<com.example.lms.model.Assignment> assigns = assignmentRepository.findByCourse(c);
                    assignmentCount += assigns.size();
                    for(com.example.lms.model.Assignment a : assigns) {
                        pendingGrade += submissionRepository.countByAssignmentAndStatus(a, "submitted");
                    }
                }

                model.addAttribute("totalStudents", totalStudents);
                model.addAttribute("pendingGrade", pendingGrade);
                model.addAttribute("assignmentCount", assignmentCount);
            }
        }
        return "fdashboard";
    }

    @GetMapping("/f-assignments")
    public String fassignments(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> fOpt = userRepository.findByEmail(principal.getName());
            if(fOpt.isPresent()) {
                User faculty = fOpt.get();
                
                List<Course> myCourses = courseRepository.findByInstructor(faculty);
                model.addAttribute("myCourses", myCourses);

                List<com.example.lms.model.Assignment> assignments = new java.util.ArrayList<>();
                List<AssignmentSubmission> pendingSubmissions = new java.util.ArrayList<>();
                
                for(Course c : myCourses) {
                    List<com.example.lms.model.Assignment> assigns = assignmentRepository.findByCourseOrderByCreatedAtDesc(c);
                    assignments.addAll(assigns);
                    
                    for(com.example.lms.model.Assignment a : assigns) {
                        List<AssignmentSubmission> subs = submissionRepository.findByAssignment(a);
                        // Using Java stream to filter out submitted
                        pendingSubmissions.addAll(subs.stream().filter(s -> "submitted".equals(s.getStatus())).collect(Collectors.toList()));
                    }
                }
                
                // Sort by created desc logically
                assignments.sort((a,b) -> {
                    if(a.getCreatedAt() != null && b.getCreatedAt() != null)
                        return b.getCreatedAt().compareTo(a.getCreatedAt());
                    return 0;
                });
                
                model.addAttribute("assignments", assignments);
                model.addAttribute("pendingSubmissions", pendingSubmissions);
            }
        }
        return "f-assignments";
    }

    @PostMapping("/f-create-assignment")
    public String createAssignment(
            @RequestParam("course_id") int courseId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("due_date") String dueDate,
            Principal principal) {
        if (principal != null) {
            Optional<User> fOpt = userRepository.findByEmail(principal.getName());
            Optional<Course> cOpt = courseRepository.findById(courseId);
            if(fOpt.isPresent() && cOpt.isPresent()) {
                com.example.lms.model.Assignment a = new com.example.lms.model.Assignment();
                a.setCourse(cOpt.get());
                a.setTitle(title);
                a.setDescription(description);
                a.setDueDate(dueDate);
                a.setCreatedBy(fOpt.get());
                assignmentRepository.save(a);
            }
        }
        return "redirect:/f-assignments";
    }

    @PostMapping("/f-grade")
    public String gradeSubmission(
            @RequestParam("submission_id") int submissionId,
            @RequestParam("marks") int marks,
            @RequestParam("feedback") String feedback) {
        Optional<AssignmentSubmission> subOpt = submissionRepository.findById(submissionId);
        if(subOpt.isPresent()) {
            AssignmentSubmission sub = subOpt.get();
            sub.setMarks(marks);
            sub.setFeedback(feedback);
            sub.setStatus("graded");
            submissionRepository.save(sub);
        }
        return "redirect:/f-assignments";
    }

    @GetMapping("/api/notices")
    @ResponseBody
    public ResponseEntity<List<Notice>> getNoticesApi() {
        return ResponseEntity.ok(noticeRepository.findTop10ByOrderByIdDesc());
    }
}
