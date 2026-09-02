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

@Controller
@RequestMapping("/admin/exams")
public class AdminExamController {

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private ExamResultRepository examResultRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/monitor")
    public String monitorExams(HttpSession session, Model model) {
        String role = (String) session.getAttribute("role");
        if (!"Admin".equalsIgnoreCase(role)) return "redirect:/login";

        List<Exam> allExams = examRepository.findAll();
        List<ExamResult> allResults = examResultRepository.findAll();
        
        // Audit info: Total exams, total submissions
        model.addAttribute("totalExams", allExams.size());
        model.addAttribute("totalResults", allResults.size());
        
        // List of all exams for audit trail
        model.addAttribute("exams", allExams);
        
        // List of all submissions for monitoring
        model.addAttribute("results", allResults);

        return "admin/exam-monitor";
    }

    @PostMapping("/delete/{examId}")
    public String deleteExam(@PathVariable Integer examId, RedirectAttributes redirectAttributes, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"Admin".equalsIgnoreCase(role)) return "redirect:/login";

        examRepository.deleteById(examId);
        redirectAttributes.addFlashAttribute("message", "Exam deleted successfully by Admin.");
        return "redirect:/admin/exams/monitor";
    }
}
