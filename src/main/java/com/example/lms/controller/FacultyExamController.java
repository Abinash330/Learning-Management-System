package com.example.lms.controller;

import com.example.lms.model.*;
import com.example.lms.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/faculty/exams")
public class FacultyExamController {

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listExams(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");

        if (email == null || !"Faculty".equalsIgnoreCase(role)) {
            return "redirect:/login";
        }

        User faculty = userRepository.findByEmail(email).orElseThrow();
        List<Exam> exams = examRepository.findByFaculty(faculty);
        model.addAttribute("exams", exams);
        
        // Also fetch courses for the creation form
        List<Course> courses = courseRepository.findByInstructor(faculty);
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
        User faculty = userRepository.findByEmail(email).orElseThrow();
        Course course = courseRepository.findById(courseId).orElseThrow();

        Exam exam = new Exam();
        exam.setTitle(title);
        exam.setCourse(course);
        exam.setFaculty(faculty);
        exam.setTotalMarks(totalMarks);
        exam.setTimeLimit(timeLimit);
        exam.setStatus("Draft");

        examRepository.save(exam);
        redirectAttributes.addFlashAttribute("message", "Exam created successfully! Now add questions.");
        return "redirect:/faculty/exams/questions/" + exam.getId();
    }

    @GetMapping("/questions/{examId}")
    public String manageQuestions(@PathVariable Integer examId, HttpSession session, Model model) {
        String role = (String) session.getAttribute("role");
        if (!"Faculty".equalsIgnoreCase(role)) return "redirect:/login";

        Exam exam = examRepository.findById(examId).orElseThrow();
        List<Question> questions = questionRepository.findByExam(exam);
        
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
        
        Exam exam = examRepository.findById(examId).orElseThrow();
        Question question = (questionId != null) ? questionRepository.findById(questionId).orElse(new Question()) : new Question();
        
        question.setExam(exam);
        question.setText(text);
        question.setMarks(marks);
        questionRepository.save(question);

        // Clear existing options if updating
        if (questionId != null) {
            List<Option> existingOptions = optionRepository.findByQuestion(question);
            optionRepository.deleteAll(existingOptions);
        }

        for (int i = 0; i < optionTexts.size(); i++) {
            Option opt = new Option();
            opt.setQuestion(question);
            opt.setText(optionTexts.get(i));
            opt.setIsCorrect(i == correctOptionIndex);
            optionRepository.save(opt);
        }

        redirectAttributes.addFlashAttribute("message", "Question saved successfully!");
        return "redirect:/faculty/exams/questions/" + examId;
    }

    @PostMapping("/status/toggle/{examId}")
    public String toggleStatus(@PathVariable Integer examId, RedirectAttributes redirectAttributes) {
        Exam exam = examRepository.findById(examId).orElseThrow();
        exam.setStatus(exam.getStatus().equals("Draft") ? "Live" : "Draft");
        examRepository.save(exam);
        
        redirectAttributes.addFlashAttribute("message", "Exam status updated to " + exam.getStatus());
        return "redirect:/faculty/exams";
    }

    @PostMapping("/delete/{examId}")
    public String deleteExam(@PathVariable Integer examId, RedirectAttributes redirectAttributes) {
        examRepository.deleteById(examId);
        redirectAttributes.addFlashAttribute("message", "Exam deleted successfully.");
        return "redirect:/faculty/exams";
    }

    @GetMapping("/questions/{questionId}/options")
    @ResponseBody
    public List<java.util.Map<String, Object>> getQuestionOptions(@PathVariable Integer questionId) {
        Question q = questionRepository.findById(questionId).orElseThrow();
        List<Option> options = optionRepository.findByQuestion(q);
        List<java.util.Map<String, Object>> result = new java.util.ArrayList<>();
        for (Option opt : options) {
            java.util.Map<String, Object> map = new java.util.HashMap<>();
            map.put("id", opt.getId());
            map.put("text", opt.getText());
            map.put("isCorrect", opt.getIsCorrect());
            result.add(map);
        }
        return result;
    }
}
