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
import com.example.lms.model.Doubt;
import com.example.lms.model.VideoLecture;
import com.example.lms.repository.AssignmentRepository;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.DoubtRepository;
import com.example.lms.repository.EnrollmentRepository;
import com.example.lms.repository.NoticeRepository;
import com.example.lms.repository.SubmissionRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.repository.ExamRepository;
import com.example.lms.repository.ExamResultRepository;
import com.example.lms.repository.VideoLectureRepository;
import java.util.stream.Collectors;

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
    @Autowired
    private ExamRepository examRepository;
    @Autowired
    private ExamResultRepository examResultRepository;
    @Autowired
    private VideoLectureRepository videoLectureRepository;
    @Autowired
    private DoubtRepository doubtRepository;

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

                // Calculate Pending Assignments
                long totalAssignments = 0;
                List<Course> courses = enrolledCourses.stream().map(Enrollment::getCourse).collect(Collectors.toList());
                for (Course c : courses) {
                    totalAssignments += assignmentRepository.findByCourse(c).size();
                }
                model.addAttribute("totalAssignments", totalAssignments);

                // Calculate Active Exams
                long activeExams = 0;
                if (!courses.isEmpty()) {
                    activeExams = examRepository.findByCourseInAndStatus(courses, "Live").size();
                }
                model.addAttribute("activeExams", activeExams);

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
                User student = uOpt.get();
                List<Enrollment> enrollments = enrollmentRepository.findByStudent(student);

                // Calculate dynamic progress
                for(Enrollment e : enrollments) {
                    Course course = e.getCourse();
                    int totalTasks = 0;
                    int completedTasks = 0;

                    // Assignments
                    List<com.example.lms.model.Assignment> assignments = assignmentRepository.findByCourse(course);
                    totalTasks += assignments.size();
                    for(com.example.lms.model.Assignment a : assignments) {
                         if(submissionRepository.findByAssignmentAndStudent(a, student).isPresent()) {
                             completedTasks++;
                         }
                    }

                    // Exams
                    List<com.example.lms.model.Exam> exams = examRepository.findByCourse(course);
                    totalTasks += exams.size();
                    for(com.example.lms.model.Exam ex : exams) {
                         if(examResultRepository.findByStudentAndExam(student, ex).isPresent()) {
                             completedTasks++;
                         }
                    }

                    int progress = 0;
                    if(totalTasks > 0) {
                         progress = (int) Math.round((completedTasks * 100.0) / totalTasks);
                    }
                    e.setProgress(progress);
                    enrollmentRepository.save(e);
                }

                model.addAttribute("courses", enrollments);
            }
        }
        return "s-courses";
    }

    @GetMapping("/s-browse-courses")
    public String sbrowsecourses(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User student = uOpt.get();
                List<Course> allCourses = courseRepository.findAll();
                List<Enrollment> enrollments = enrollmentRepository.findByStudent(student);
                List<Integer> enrolledCourseIds = enrollments.stream()
                        .map(e -> e.getCourse().getId())
                        .collect(Collectors.toList());
                
                model.addAttribute("allCourses", allCourses);
                model.addAttribute("enrolledCourseIds", enrolledCourseIds);
                model.addAttribute("name", student.getName());
            }
        }
        return "s-browse-courses";
    }

    @PostMapping("/s-enroll")
    public String senroll(@RequestParam("course_id") Integer courseId, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            Optional<Course> cOpt = courseRepository.findById(courseId);
            if(uOpt.isPresent() && cOpt.isPresent()) {
                User student = uOpt.get();
                Course course = cOpt.get();
                if (enrollmentRepository.findByStudentAndCourse(student, course).isEmpty()) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setStudent(student);
                    enrollment.setCourse(course);
                    enrollment.setProgress(0);
                    enrollmentRepository.save(enrollment);
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
                    List<com.example.lms.model.Assignment> assignments = assignmentRepository.findByCourseOrderByCreatedAtDesc(e.getCourse());
                    for(com.example.lms.model.Assignment a : assignments) {
                        Optional<AssignmentSubmission> subOpt = submissionRepository.findByAssignmentAndStudent(a, user);
                        if(subOpt.isPresent()) {
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
            if(cOpt.isPresent()) {
                 Course course = cOpt.get();
                 model.addAttribute("course", course);
                 model.addAttribute("videos", videoLectureRepository.findByCourseIn(List.of(course)));
                 model.addAttribute("assignments", assignmentRepository.findByCourseOrderByCreatedAtDesc(course));
                 List<com.example.lms.model.Exam> allExams = examRepository.findByCourse(course);
                 // Only show Live exams or maybe all exams for history
                 model.addAttribute("exams", allExams);
            }
        }
        return "s-start-course";
    }

    @GetMapping("/student-notices")
    public String studentNotices(Model model) {
        model.addAttribute("notices", noticeRepository.findByTargetAudienceInOrderByIdDesc(java.util.List.of("ALL", "STUDENT")));
        return "student-notices";
    }

    // ── /student-exams alias: redirect to the StudentExamController ──
    @GetMapping("/student-exams")
    public String studentExamsAlias() {
        return "redirect:/student/exams";
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

    @PostMapping("/s-update-profile")
    public String updateProfile(
            @RequestParam("name") String name,
            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
            Principal principal,
            Model model,
            jakarta.servlet.http.HttpSession session) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User user = uOpt.get();
                if (name != null && !name.isBlank()) user.setName(name.trim());
                if (mobile != null && !mobile.isBlank()) user.setMobile(mobile.trim());
                userRepository.save(user);
                session.setAttribute("name", user.getName());
                model.addAttribute("user", user);
                model.addAttribute("name", user.getName());
                model.addAttribute("successMsg", "Your profile has been updated successfully.");
            }
        }
        return "s-profile";
    }

    // ── Video Lecture pages ───────────────────────────────────────────────

    @GetMapping("/s-videos")
    public String svideos(Model model, Principal principal) {
        if (principal != null) {
            Optional<User> uOpt = userRepository.findByEmail(principal.getName());
            if (uOpt.isPresent()) {
                User student = uOpt.get();
                List<Enrollment> enrollments = enrollmentRepository.findByStudent(student);
                List<Course> courses = enrollments.stream().map(Enrollment::getCourse).collect(Collectors.toList());
                List<VideoLecture> videos = courses.isEmpty()
                        ? List.of()
                        : videoLectureRepository.findByCourseIn(courses);
                model.addAttribute("videos", videos);
                model.addAttribute("courses", courses);
                model.addAttribute("name", student.getName());
            }
        }
        return "s-videos";
    }

    @GetMapping("/s-watch/{id}")
    public String swatch(@PathVariable Long id, Model model, Principal principal) {
        Optional<VideoLecture> vOpt = videoLectureRepository.findById(id);
        if (vOpt.isEmpty()) return "redirect:/s-videos";
        VideoLecture video = vOpt.get();
        model.addAttribute("video", video);

        List<Doubt> doubts = doubtRepository.findByVideo(video);
        model.addAttribute("doubts", doubts);

        if (principal != null) {
            userRepository.findByEmail(principal.getName())
                    .ifPresent(u -> model.addAttribute("studentName", u.getName()));
        }
        return "s-watch";
    }

    @PostMapping("/s-ask-doubt")
    public String askDoubt(
            @RequestParam("video_id") Long videoId,
            @RequestParam("questionText") String questionText,
            Principal principal) {
        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userRepository.findByEmail(principal.getName());
        Optional<VideoLecture> vOpt = videoLectureRepository.findById(videoId);
        if (uOpt.isPresent() && vOpt.isPresent() && questionText != null && !questionText.isBlank()) {
            Doubt d = new Doubt();
            d.setQuestionText(questionText.trim());
            d.setStatus("OPEN");
            d.setAskedAt(LocalDateTime.now());
            d.setStudent(uOpt.get());
            d.setVideo(vOpt.get());
            doubtRepository.save(d);
        }
        return "redirect:/s-watch/" + videoId;
    }
}
