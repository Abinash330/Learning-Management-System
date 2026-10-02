package com.example.lms.exam.controller;

import com.example.lms.course.model.Course;
import com.example.lms.course.service.CourseService;
import com.example.lms.exam.model.Exam;
import com.example.lms.exam.model.Option;
import com.example.lms.exam.model.Question;
import com.example.lms.exam.service.ExamService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/faculty/exams")
public class FacultyExamController {

    private final ExamService examService;
    private final CourseService courseService;
    private final UserService userService;

    @Autowired
    public FacultyExamController(ExamService examService, CourseService courseService, UserService userService) {
        this.examService = examService;
        this.courseService = courseService;
        this.userService = userService;
    }

    @GetMapping
    public String listExams(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");

        if (email == null || !"Faculty".equalsIgnoreCase(role)) {
            return "redirect:/login";
        }

        User faculty = userService.getUserByEmail(email).orElseThrow();
        List<Exam> exams = examService.getExamsByFaculty(faculty);
        model.addAttribute("exams", exams);
        
        // Also fetch courses for the creation form
        List<Course> courses = courseService.getCoursesByInstructor(faculty);
        model.addAttribute("courses", courses);
        
        return "faculty/exam-manage"; 
    }

    @PostMapping("/create")
    public String createExam(@RequestParam("title") String title,
                             @RequestParam("courseId") Integer courseId,
                             @RequestParam("totalMarks") Integer totalMarks,
                             @RequestParam("timeLimit") Integer timeLimit,
                             HttpSession session, RedirectAttributes redirectAttributes) {
        
        String email = (String) session.getAttribute("email");
        User faculty = userService.getUserByEmail(email).orElseThrow();

        Exam exam = examService.createExam(title, courseId, totalMarks, timeLimit, faculty);
        redirectAttributes.addFlashAttribute("message", "Exam created successfully! Now add questions.");
        return "redirect:/faculty/exams/questions/" + exam.getId();
    }

    @GetMapping("/questions/{examId}")
    public String manageQuestions(@PathVariable Integer examId, HttpSession session, Model model) {
        String role = (String) session.getAttribute("role");
        if (!"Faculty".equalsIgnoreCase(role)) return "redirect:/login";

        Exam exam = examService.getExamById(examId).orElseThrow();
        List<Question> questions = examService.getQuestionsByExam(exam);
        
        model.addAttribute("exam", exam);
        model.addAttribute("questions", questions);
        return "faculty/exam-questions";
    }

    @PostMapping("/questions/save")
    public String saveQuestion(@RequestParam("examId") Integer examId,
                               @RequestParam(value = "questionId", required = false) Integer questionId,
                               @RequestParam("text") String text,
                               @RequestParam("marks") Integer marks,
                               @RequestParam("options") List<String> optionTexts,
                               @RequestParam("correctOptionIndex") Integer correctOptionIndex,
                               RedirectAttributes redirectAttributes) {
        
        examService.saveQuestionWithOptions(examId, questionId, text, marks, optionTexts, correctOptionIndex);
        redirectAttributes.addFlashAttribute("message", "Question saved successfully!");
        return "redirect:/faculty/exams/questions/" + examId;
    }

    @PostMapping("/status/toggle/{examId}")
    public String toggleStatus(@PathVariable Integer examId, RedirectAttributes redirectAttributes) {
        examService.toggleExamStatus(examId);
        Exam exam = examService.getExamById(examId).orElseThrow();
        redirectAttributes.addFlashAttribute("message", "Exam status updated to " + exam.getStatus());
        return "redirect:/faculty/exams";
    }

    @PostMapping("/delete/{examId}")
    public String deleteExam(@PathVariable Integer examId, RedirectAttributes redirectAttributes) {
        examService.deleteExam(examId);
        redirectAttributes.addFlashAttribute("message", "Exam deleted successfully.");
        return "redirect:/faculty/exams";
    }

    @GetMapping("/questions/{questionId}/options")
    @ResponseBody
    public List<Map<String, Object>> getQuestionOptions(@PathVariable Integer questionId) {
        // Find question
        Question q = new Question();
        q.setId(questionId);
        List<Option> options = examService.getOptionsByQuestion(q);
        List<Map<String, Object>> result = new ArrayList<>();
        for (Option opt : options) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", opt.getId());
            map.put("text", opt.getText());
            map.put("isCorrect", opt.getIsCorrect());
            result.add(map);
        }
        return result;
    }
}
