package com.example.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.time.LocalDateTime;

import com.example.lms.model.AssignmentSubmission;
import com.example.lms.model.Course;
import com.example.lms.model.Enrollment;
import com.example.lms.model.User;
import com.example.lms.repository.AssignmentRepository;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.EnrollmentRepository;
import com.example.lms.repository.NoticeRepository;
import com.example.lms.repository.SubmissionRepository;
import com.example.lms.repository.UserRepository;

@Controller
public class StudentController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private AssignmentRepository assignmentRepository;
    @Autowired
    private SubmissionRepository submissionRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private NoticeRepository noticeRepository;

    @GetMapping("/sdashboard")
    public String sdashboard(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            Optional<User> uOpt = userRepository.findByEmail(email);
            if(uOpt.isPresent()) {
                User user = uOpt.get();
                model.addAttribute("name", user.getName());

                long enrolledCount = enrollmentRepository.countByStudent(user);
                model.addAttribute("enrolledCount", enrolledCount);

                long completedCount = enrollmentRepository.countByStudentAndProgress(user, 100);
                model.addAttribute("completedCount", completedCount);

                List<Enrollment> enrolledCourses = enrollmentRepository.findByStudent(user);
                model.addAttribute("enrolledCourses", enrolledCourses);

                // For simplicity, we just count pending assignments roughly via code or assume 0 if complex
                model.addAttribute("pendingAssignments", 0);

                model.addAttribute("notices", noticeRepository.findTop3ByOrderByIdDesc());
            }
        }
        return "sdashboard";
    }

    @GetMapping("/s-courses")
    public String scourses(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            if(uOpt.isPresent()) {
                model.addAttribute("courses", enrollmentRepository.findByStudent(uOpt.get()));
            }
        }
        return "s-courses";
    }

    @PostMapping("/s-update-progress")
    public String updateProgress(
            @RequestParam("course_id") int courseId,
            @RequestParam("progress") int progress,
            Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            Optional<Course> cOpt = courseRepository.findById(courseId);
            if(uOpt.isPresent() && cOpt.isPresent()) {
                Optional<Enrollment> eOpt = enrollmentRepository.findByStudentAndCourse(uOpt.get(), cOpt.get());
                if(eOpt.isPresent()) {
                    Enrollment e = eOpt.get();
                    e.setProgress(Math.max(0, Math.min(100, progress)));
                    enrollmentRepository.save(e);
                }
            }
        }
        return "redirect:/s-courses";
    }

    @GetMapping("/s-assignments")
    public String sassignments(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            if(uOpt.isPresent()) {
                User user = uOpt.get();
                List<Enrollment> enrollments = enrollmentRepository.findByStudent(user);
                List<com.example.lms.model.Assignment> allAssignments = new java.util.ArrayList<>();
                for(Enrollment e : enrollments) {
                    allAssignments.addAll(assignmentRepository.findByCourseOrderByCreatedAtDesc(e.getCourse()));
                }
                
                // Add submission details logic if needed in view layer by adding it, or wrap it
                model.addAttribute("assignments", allAssignments);
                model.addAttribute("student", user); // so JSP can check submissions if needed
            }
        }
        return "s-assignments";
    }

    @PostMapping("/s-submit")
    public String submitAssignment(
            @RequestParam("assignment_id") int assignmentId,
            @RequestParam("answer") String answer,
            Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            Optional<com.example.lms.model.Assignment> aOpt = assignmentRepository.findById(assignmentId);
            if(uOpt.isPresent() && aOpt.isPresent()) {
                Optional<AssignmentSubmission> subOpt = submissionRepository.findByAssignmentAndStudent(aOpt.get(), uOpt.get());
                AssignmentSubmission sub;
                if(subOpt.isPresent()) {
                    sub = subOpt.get();
                } else {
                    sub = new AssignmentSubmission();
                    sub.setAssignment(aOpt.get());
                    sub.setStudent(uOpt.get());
                }
                sub.setAnswer(answer);
                sub.setStatus("submitted");
                sub.setSubmittedAt(LocalDateTime.now());
                submissionRepository.save(sub);
            }
        }
        return "redirect:/s-assignments";
    }

    @GetMapping("/s-search")
    public String ssearch(@RequestParam(name = "q", required = false, defaultValue = "") String query,
                          Model model, Principal principal) {
        model.addAttribute("courses", courseRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(query, query));
        model.addAttribute("notices", noticeRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrderByIdDesc(query, query));
        model.addAttribute("query", query);
        return "s-search";
    }

    @GetMapping("/s-start-course")
    public String sstartcourse(@RequestParam(name = "id", required = false, defaultValue = "0") int courseId,
                               Model model) {
        if (courseId > 0) {
            Optional<Course> cOpt = courseRepository.findById(courseId);
            cOpt.ifPresent(course -> model.addAttribute("course", course));
        }
        return "s-start-course";
    }

    @GetMapping("/s-premium")
    public String spremium() { return "s-premium"; }

    @GetMapping("/s-profile")
    public String sprofile(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            if(uOpt.isPresent()) {
                model.addAttribute("user", uOpt.get());
                model.addAttribute("name", uOpt.get().getName());
            }
        }
        return "s-profile";
    }
}
