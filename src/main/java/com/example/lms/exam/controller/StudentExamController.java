package com.example.lms.exam.controller;

import com.example.lms.course.model.Course;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.enrollment.service.EnrollmentService;
import com.example.lms.exam.model.*;
import com.example.lms.exam.service.ExamService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/student/exams")
public class StudentExamController {

    private final ExamService examService;
    private final EnrollmentService enrollmentService;
    private final UserService userService;

    @Autowired
    public StudentExamController(ExamService examService, EnrollmentService enrollmentService, UserService userService) {
        this.examService = examService;
        this.enrollmentService = enrollmentService;
        this.userService = userService;
    }

    @GetMapping
    public String listExams(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email == null) return "redirect:/login";

        User student = userService.getUserByEmail(email).orElseThrow();
        List<Enrollment> enrollments = enrollmentService.getEnrollmentsByStudent(student);
        List<Course> courses = enrollments.stream().map(Enrollment::getCourse).collect(Collectors.toList());

        List<Exam> exams = examService.getLiveExamsByCourses(courses);
        
        // Map to store if student has already taken the exam
        Map<Integer, ExamResult> resultsMap = new HashMap<>();
        for (Exam exam : exams) {
            examService.getResultByStudentAndExam(student, exam).ifPresent(res -> resultsMap.put(exam.getId(), res));
        }

        model.addAttribute("exams", exams);
        model.addAttribute("resultsMap", resultsMap);
        return "student/exams";
    }

    @GetMapping("/portal/{examId}")
    public String startExam(@PathVariable Integer examId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("email");
        User student = userService.getUserByEmail(email).orElseThrow();
        Exam exam = examService.getExamById(examId).orElseThrow();

        // Security check: Is student enrolled in the course?
        if (enrollmentService.getEnrollmentByStudentAndCourse(student, exam.getCourse()).isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "You are not enrolled in this course.");
            return "redirect:/student/exams";
        }

        // Check if already taken
        if (examService.getResultByStudentAndExam(student, exam).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "You have already completed this exam.");
            return "redirect:/student/exams";
        }

        List<Question> questions = examService.getQuestionsByExam(exam);
        Map<Integer, List<Option>> questionOptions = new HashMap<>();
        for (Question q : questions) {
            questionOptions.put(q.getId(), examService.getOptionsByQuestion(q));
        }

        model.addAttribute("exam", exam);
        model.addAttribute("questions", questions);
        model.addAttribute("questionOptions", questionOptions);
        return "student/exam-portal";
    }

    @PostMapping("/submit")
    public String submitExam(@RequestParam("examId") Integer examId,
                             @RequestParam Map<String, String> allParams,
                             HttpSession session, RedirectAttributes redirectAttributes) {
        
        String email = (String) session.getAttribute("email");
        User student = userService.getUserByEmail(email).orElseThrow();

        ExamResult result = examService.submitExam(examId, allParams, student);
        redirectAttributes.addFlashAttribute("message", "Exam submitted successfully! You scored " + result.getScore() + " marks.");
        return "redirect:/student/exams";
    }

    @GetMapping("/review/{examId}")
    public String reviewExam(@PathVariable Integer examId, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email == null) return "redirect:/login";

        User student = userService.getUserByEmail(email).orElseThrow();
        Exam exam = examService.getExamById(examId).orElseThrow();
        
        ExamResult result = examService.getResultByStudentAndExam(student, exam).orElse(null);
        if (result == null) {
            return "redirect:/student/exams";
        }

        List<StudentAnswer> studentAnswers = examService.getStudentAnswersByResult(result);
        Map<Integer, Integer> selectedOptionsMap = new HashMap<>();
        for(StudentAnswer sa : studentAnswers) {
            selectedOptionsMap.put(sa.getQuestion().getId(), sa.getSelectedOption().getId());
        }

        List<Question> questions = examService.getQuestionsByExam(exam);
        Map<Integer, List<Option>> questionOptions = new HashMap<>();
        for (Question q : questions) {
            questionOptions.put(q.getId(), examService.getOptionsByQuestion(q));
        }

        model.addAttribute("exam", exam);
        model.addAttribute("result", result);
        model.addAttribute("questions", questions);
        model.addAttribute("questionOptions", questionOptions);
        model.addAttribute("selectedOptionsMap", selectedOptionsMap);

        return "student/exam-review";
    }
}
