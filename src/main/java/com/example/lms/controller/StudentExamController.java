package com.example.lms.controller;

import com.example.lms.model.*;
import com.example.lms.repository.*;
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

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ExamResultRepository examResultRepository;

    @Autowired
    private StudentAnswerRepository studentAnswerRepository;

    @GetMapping
    public String listExams(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email == null) return "redirect:/login";

        User student = userRepository.findByEmail(email).orElseThrow();
        List<Enrollment> enrollments = enrollmentRepository.findByStudent(student);
        List<Course> courses = enrollments.stream().map(Enrollment::getCourse).collect(Collectors.toList());

        List<Exam> exams = examRepository.findByCourseInAndStatus(courses, "Live");
        
        // Map to store if student has already taken the exam
        Map<Integer, ExamResult> resultsMap = new HashMap<>();
        for (Exam exam : exams) {
            examResultRepository.findByStudentAndExam(student, exam).ifPresent(res -> resultsMap.put(exam.getId(), res));
        }

        model.addAttribute("exams", exams);
        model.addAttribute("resultsMap", resultsMap);
        return "student-exams";
    }

    @GetMapping("/portal/{examId}")
    public String startExam(@PathVariable Integer examId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("email");
        User student = userRepository.findByEmail(email).orElseThrow();
        Exam exam = examRepository.findById(examId).orElseThrow();

        // Security check: Is student enrolled in the course?
        if (enrollmentRepository.findByStudentAndCourse(student, exam.getCourse()).isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "You are not enrolled in this course.");
            return "redirect:/student/exams";
        }

        // Check if already taken
        if (examResultRepository.findByStudentAndExam(student, exam).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "You have already completed this exam.");
            return "redirect:/student/exams";
        }

        List<Question> questions = questionRepository.findByExam(exam);
        Map<Integer, List<Option>> questionOptions = new HashMap<>();
        for (Question q : questions) {
            questionOptions.put(q.getId(), optionRepository.findByQuestion(q));
        }

        model.addAttribute("exam", exam);
        model.addAttribute("questions", questions);
        model.addAttribute("questionOptions", questionOptions);
        return "student-exam-portal";
    }

    @PostMapping("/submit")
    public String submitExam(@RequestParam("examId") Integer examId,
                             @RequestParam Map<String, String> allParams,
                             HttpSession session, RedirectAttributes redirectAttributes) {
        
        String email = (String) session.getAttribute("email");
        User student = userRepository.findByEmail(email).orElseThrow();
        Exam exam = examRepository.findById(examId).orElseThrow();

        ExamResult result = new ExamResult();
        result.setStudent(student);
        result.setExam(exam);
        result.setScore(0);
        examResultRepository.save(result);

        List<Question> questions = questionRepository.findByExam(exam);
        int totalScore = 0;

        for (Question q : questions) {
            String selectedOptionIdStr = allParams.get("question_" + q.getId());
            if (selectedOptionIdStr != null) {
                Integer selectedOptionId = Integer.parseInt(selectedOptionIdStr);
                Option selectedOption = optionRepository.findById(selectedOptionId).orElseThrow();
                
                StudentAnswer sa = new StudentAnswer(result, q, selectedOption);
                studentAnswerRepository.save(sa);

                if (Boolean.TRUE.equals(selectedOption.getIsCorrect())) {
                    totalScore += q.getMarks();
                }
            }
        }

        result.setScore(totalScore);
        examResultRepository.save(result);

        redirectAttributes.addFlashAttribute("message", "Exam submitted successfully! You scored " + totalScore + " marks.");
        return "redirect:/student/exams";
    }

    @GetMapping("/review/{examId}")
    public String reviewExam(@PathVariable Integer examId, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email == null) return "redirect:/login";

        User student = userRepository.findByEmail(email).orElseThrow();
        Exam exam = examRepository.findById(examId).orElseThrow();
        
        ExamResult result = examResultRepository.findByStudentAndExam(student, exam).orElse(null);
        if (result == null) {
            return "redirect:/student/exams";
        }

        List<StudentAnswer> studentAnswers = studentAnswerRepository.findByExamResult(result);
        Map<Integer, Integer> selectedOptionsMap = new HashMap<>();
        for(StudentAnswer sa : studentAnswers) {
            selectedOptionsMap.put(sa.getQuestion().getId(), sa.getSelectedOption().getId());
        }

        List<Question> questions = questionRepository.findByExam(exam);
        Map<Integer, List<Option>> questionOptions = new HashMap<>();
        for (Question q : questions) {
            questionOptions.put(q.getId(), optionRepository.findByQuestion(q));
        }

        model.addAttribute("exam", exam);
        model.addAttribute("result", result);
        model.addAttribute("questions", questions);
        model.addAttribute("questionOptions", questionOptions);
        model.addAttribute("selectedOptionsMap", selectedOptionsMap);

        return "student-exam-review";
    }
}
