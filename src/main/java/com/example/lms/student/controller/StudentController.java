package com.example.lms.student.controller;

import com.example.lms.assignment.model.Assignment;
import com.example.lms.assignment.model.AssignmentSubmission;
import com.example.lms.assignment.service.AssignmentService;
import com.example.lms.course.model.Course;
import com.example.lms.course.service.CourseService;
import com.example.lms.doubt.model.Doubt;
import com.example.lms.doubt.service.DoubtService;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.enrollment.service.EnrollmentService;
import com.example.lms.exam.model.Exam;
import com.example.lms.exam.service.ExamService;
import com.example.lms.notice.service.NoticeService;
import com.example.lms.student.dto.StudentDashboardDTO;
import com.example.lms.student.service.StudentService;
import com.example.lms.user.dto.UserProfileUpdateDTO;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import com.example.lms.video.model.VideoLecture;
import com.example.lms.video.service.VideoService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class StudentController {

    private final UserService userService;
    private final CourseService courseService;
    private final EnrollmentService enrollmentService;
    private final AssignmentService assignmentService;
    private final ExamService examService;
    private final NoticeService noticeService;
    private final VideoService videoService;
    private final DoubtService doubtService;
    private final StudentService studentService;

    @Autowired
    public StudentController(UserService userService,
                             CourseService courseService,
                             EnrollmentService enrollmentService,
                             AssignmentService assignmentService,
                             ExamService examService,
                             NoticeService noticeService,
                             VideoService videoService,
                             DoubtService doubtService,
                             StudentService studentService) {
        this.userService = userService;
        this.courseService = courseService;
        this.enrollmentService = enrollmentService;
        this.assignmentService = assignmentService;
        this.examService = examService;
        this.noticeService = noticeService;
        this.videoService = videoService;
        this.doubtService = doubtService;
        this.studentService = studentService;
    }

    @GetMapping("/sdashboard")
    public String sdashboard(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            Optional<User> uOpt = userService.getUserByEmail(email);
            if (uOpt.isPresent()) {
                User user = uOpt.get();
                StudentDashboardDTO dto = studentService.getStudentDashboard(user);
                model.addAttribute("name", dto.getStudentName());
                model.addAttribute("enrolledCount", dto.getEnrolledCount());
                model.addAttribute("completedCount", dto.getCompletedCount());
                model.addAttribute("enrolledCourses", dto.getEnrolledCourses());
                model.addAttribute("totalAssignments", dto.getTotalAssignments());
                model.addAttribute("activeExams", dto.getActiveExams());
                model.addAttribute("notices", dto.getNotices());
            }
        }
        return "student/dashboard";
    }

    @GetMapping("/s-courses")
    public String scourses(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User student = uOpt.get();
                List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(student);

                // Calculate dynamic progress
                for (Enrollment e : enrollments) {
                    Course course = e.getCourse();
                    int totalTasks = 0;
                    int completedTasks = 0;

                    // Assignments
                    List<Assignment> assignments = assignmentService.getAssignmentsByCourse(course);
                    totalTasks += assignments.size();
                    for (Assignment a : assignments) {
                        if (assignmentService.getSubmissionByAssignmentAndStudent(a, student).isPresent()) {
                            completedTasks++;
                        }
                    }

                    // Exams
                    List<Exam> exams = examService.getExamsByCourse(course);
                    totalTasks += exams.size();
                    for (Exam ex : exams) {
                        if (examService.getResultByStudentAndExam(student, ex).isPresent()) {
                            completedTasks++;
                        }
                    }

                    int progress = 0;
                    if (totalTasks > 0) {
                        progress = (int) Math.round((completedTasks * 100.0) / totalTasks);
                    }
                    enrollmentService.updateProgress(e, progress);
                }

                model.addAttribute("courses", enrollments);
            }
        }
        return "student/courses";
    }

    @GetMapping("/s-browse-courses")
    public String sbrowsecourses(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User student = uOpt.get();
                List<Course> allCourses = courseService.getAllCourses();
                List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(student);
                List<Integer> enrolledCourseIds = enrollments.stream()
                        .map(e -> e.getCourse().getId())
                        .collect(Collectors.toList());
                
                model.addAttribute("allCourses", allCourses);
                model.addAttribute("enrolledCourseIds", enrolledCourseIds);
                model.addAttribute("name", student.getName());
            }
        }
        return "student/browse-courses";
    }

    @PostMapping("/s-enroll")
    public String senroll(@RequestParam("course_id") Integer courseId, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            Optional<Course> cOpt = courseService.getCourseById(courseId);
            if (uOpt.isPresent() && cOpt.isPresent()) {
                enrollmentService.enrollStudent(uOpt.get(), cOpt.get());
            }
        }
        return "redirect:/s-courses";
    }

    @GetMapping("/s-assignments")
    public String sassignments(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User user = uOpt.get();
                List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(user);
                List<Assignment> allAssignments = new ArrayList<>();
                for (Enrollment e : enrollments) {
                    List<Assignment> assignments = assignmentService.getAssignmentsByCourseOrderByCreatedAtDesc(e.getCourse());
                    for (Assignment a : assignments) {
                        Optional<AssignmentSubmission> subOpt = assignmentService.getSubmissionByAssignmentAndStudent(a, user);
                        if (subOpt.isPresent()) {
                            AssignmentSubmission sub = subOpt.get();
                            a.setSubStatus(sub.getStatus());
                            a.setMarks(sub.getMarks());
                        } else {
                            a.setSubStatus("pending");
                        }
                        allAssignments.add(a);
                    }
                }
                model.addAttribute("assignments", allAssignments);
                model.addAttribute("student", user);
            }
        }
        return "student/assignments";
    }

    @PostMapping("/s-submit")
    public String submitAssignment(
            @RequestParam("assignment_id") int assignmentId,
            @RequestParam("answer") String answer,
            Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            uOpt.ifPresent(user -> assignmentService.submitAssignment(assignmentId, answer, user));
        }
        return "redirect:/s-assignments";
    }

    @GetMapping("/s-search")
    public String ssearch(@RequestParam(name = "q", required = false, defaultValue = "") String query,
                          Model model) {
        model.addAttribute("courses", courseService.searchCourses(query));
        model.addAttribute("notices", noticeService.searchNotices(query));
        model.addAttribute("query", query);
        return "student/search";
    }

    @GetMapping("/s-start-course")
    public String sstartcourse(@RequestParam(name = "id", required = false, defaultValue = "0") int courseId,
                               Model model) {
        if (courseId > 0) {
            Optional<Course> cOpt = courseService.getCourseById(courseId);
            if (cOpt.isPresent()) {
                Course course = cOpt.get();
                model.addAttribute("course", course);
                model.addAttribute("videos", videoService.getVideosByCourse(course));
                model.addAttribute("assignments", assignmentService.getAssignmentsByCourseOrderByCreatedAtDesc(course));
                model.addAttribute("exams", examService.getExamsByCourse(course));
            }
        }
        return "student/start-course";
    }

    @GetMapping("/student-notices")
    public String studentNotices(Model model) {
        model.addAttribute("notices", noticeService.getNoticesByAudience(List.of("ALL", "STUDENT")));
        return "student/notices";
    }

    @GetMapping("/student-exams")
    public String studentExamsAlias() {
        return "redirect:/student/exams";
    }

    @GetMapping("/s-premium")
    public String spremium() {
        return "student/premium";
    }

    @GetMapping("/s-profile")
    public String sprofile(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            if (uOpt.isPresent()) {
                model.addAttribute("user", uOpt.get());
                model.addAttribute("name", uOpt.get().getName());
            }
        }
        return "student/profile";
    }

    @PostMapping("/s-update-profile")
    public String updateProfile(
            @RequestParam("name") String name,
            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
            Principal principal,
            Model model,
            HttpSession session) {
        if (principal != null) {
            UserProfileUpdateDTO dto = new UserProfileUpdateDTO(name, mobile);
            User user = userService.updateUserProfile(principal.getName(), dto);
            session.setAttribute("name", user.getName());
            model.addAttribute("user", user);
            model.addAttribute("name", user.getName());
            model.addAttribute("successMsg", "Your profile has been updated successfully.");
        }
        return "student/profile";
    }

    @GetMapping("/s-videos")
    public String svideos(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userService.getUserByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User student = uOpt.get();
                List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(student);
                List<Course> courses = enrollments.stream().map(Enrollment::getCourse).collect(Collectors.toList());
                List<VideoLecture> videos = videoService.getVideosByCourses(courses);
                model.addAttribute("videos", videos);
                model.addAttribute("courses", courses);
                model.addAttribute("name", student.getName());
            }
        }
        return "student/videos";
    }

    @GetMapping("/s-watch/{id}")
    public String swatch(@PathVariable Long id, Model model, Principal principal) {
        Optional<VideoLecture> vOpt = videoService.getVideoById(id);
        if (vOpt.isEmpty()) return "redirect:/s-videos";
        VideoLecture video = vOpt.get();
        model.addAttribute("video", video);

        List<Doubt> doubts = doubtService.getDoubtsByVideo(video);
        model.addAttribute("doubts", doubts);

        if (principal != null) {
            userService.getUserByEmail(principal.getName())
                    .ifPresent(u -> model.addAttribute("studentName", u.getName()));
        }
        return "student/watch";
    }

    @PostMapping("/s-ask-doubt")
    public String askDoubt(
            @RequestParam("video_id") Long videoId,
            @RequestParam("questionText") String questionText,
            Principal principal) {
        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userService.getUserByEmail(principal.getName());
        if (uOpt.isPresent() && questionText != null && !questionText.isBlank()) {
            doubtService.askDoubt(videoId, questionText, uOpt.get());
        }
        return "redirect:/s-watch/" + videoId;
    }
}
