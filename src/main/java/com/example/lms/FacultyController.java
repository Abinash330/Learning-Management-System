package com.example.lms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Collections;

@Controller
public class FacultyController {

    @Autowired
    private JdbcTemplate jdbc;

    // ── Faculty Dashboard ─────────────────────────────────────
    @GetMapping("/fdashboard")
    public String fdashboard(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            try {
                Map<String, Object> faculty = jdbc.queryForMap(
                    "SELECT id, name FROM user_master WHERE email = ?", email);
                model.addAttribute("name", faculty.get("name"));
                int facultyId = ((Number) faculty.get("id")).intValue();

                List<Map<String, Object>> courses = jdbc.queryForList(
                    "SELECT c.*, (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.id) AS enrolled_count " +
                    "FROM courses c WHERE c.instructor_id = ?", facultyId);
                model.addAttribute("courses", courses);
                model.addAttribute("courseCount", courses.size());

                Integer totalStudents = jdbc.queryForObject(
                    "SELECT COUNT(DISTINCT e.student_id) FROM enrollments e " +
                    "JOIN courses c ON e.course_id = c.id WHERE c.instructor_id = ?",
                    Integer.class, facultyId);
                model.addAttribute("totalStudents", totalStudents != null ? totalStudents : 0);

                Integer pendingGrade = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM assignment_submissions s " +
                    "JOIN assignments a ON s.assignment_id = a.id " +
                    "JOIN courses c ON a.course_id = c.id " +
                    "WHERE c.instructor_id = ? AND s.status = 'submitted'",
                    Integer.class, facultyId);
                model.addAttribute("pendingGrade", pendingGrade != null ? pendingGrade : 0);

                Integer assignmentCount = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM assignments a JOIN courses c ON a.course_id = c.id WHERE c.instructor_id = ?",
                    Integer.class, facultyId);
                model.addAttribute("assignmentCount", assignmentCount != null ? assignmentCount : 0);

            } catch (Exception e) {
                model.addAttribute("courseCount", 0);
                model.addAttribute("totalStudents", 0);
                model.addAttribute("pendingGrade", 0);
                model.addAttribute("assignmentCount", 0);
            }
        }
        return "fdashboard";
    }

    // ── Faculty Assignments Page ──────────────────────────────
    @GetMapping("/f-assignments")
    public String fassignments(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            try {
                Map<String, Object> faculty = jdbc.queryForMap(
                    "SELECT id FROM user_master WHERE email = ?", email);
                int facultyId = ((Number) faculty.get("id")).intValue();

                List<Map<String, Object>> myCourses = jdbc.queryForList(
                    "SELECT id, title FROM courses WHERE instructor_id = ?", facultyId);
                model.addAttribute("myCourses", myCourses);

                List<Map<String, Object>> assignments = jdbc.queryForList(
                    "SELECT a.*, c.title AS course_title, " +
                    "(SELECT COUNT(*) FROM assignment_submissions s WHERE s.assignment_id = a.id) AS submission_count, " +
                    "(SELECT COUNT(*) FROM assignment_submissions s WHERE s.assignment_id = a.id AND s.status='graded') AS graded_count " +
                    "FROM assignments a JOIN courses c ON a.course_id = c.id " +
                    "WHERE c.instructor_id = ? ORDER BY a.created_at DESC", facultyId);
                model.addAttribute("assignments", assignments);

                List<Map<String, Object>> pendingSubmissions = jdbc.queryForList(
                    "SELECT s.*, a.title AS assignment_title, u.name AS student_name, u.email AS student_email " +
                    "FROM assignment_submissions s " +
                    "JOIN assignments a ON s.assignment_id = a.id " +
                    "JOIN user_master u ON s.student_id = u.id " +
                    "JOIN courses c ON a.course_id = c.id " +
                    "WHERE c.instructor_id = ? AND s.status = 'submitted' ORDER BY s.submitted_at DESC", facultyId);
                model.addAttribute("pendingSubmissions", pendingSubmissions);

            } catch (Exception e) {
                model.addAttribute("myCourses", Collections.emptyList());
                model.addAttribute("assignments", Collections.emptyList());
                model.addAttribute("pendingSubmissions", Collections.emptyList());
            }
        }
        return "f-assignments";
    }

    // ── Create Assignment POST ────────────────────────────────
    @PostMapping("/f-create-assignment")
    public String createAssignment(
            @RequestParam("course_id") int courseId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("due_date") String dueDate,
            Principal principal) {
        if (principal != null) {
            try {
                Map<String, Object> faculty = jdbc.queryForMap(
                    "SELECT id FROM user_master WHERE email = ?", principal.getName());
                int facultyId = ((Number) faculty.get("id")).intValue();
                jdbc.update(
                    "INSERT INTO assignments (course_id, title, description, due_date, created_by) VALUES (?, ?, ?, ?, ?)",
                    courseId, title, description, dueDate, facultyId);
            } catch (Exception e) { /* log */ }
        }
        return "redirect:/f-assignments";
    }

    // ── Grade Submission POST ─────────────────────────────────
    @PostMapping("/f-grade")
    public String gradeSubmission(
            @RequestParam("submission_id") int submissionId,
            @RequestParam("marks") int marks,
            @RequestParam("feedback") String feedback) {
        try {
            jdbc.update(
                "UPDATE assignment_submissions SET marks=?, feedback=?, status='graded' WHERE id=?",
                marks, feedback, submissionId);
        } catch (Exception e) { /* log */ }
        return "redirect:/f-assignments";
    }

    // ── 🔔 Notices API (JSON) - used by Notification Bell ────
    @GetMapping("/api/notices")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getNoticesApi() {
        try {
            List<Map<String, Object>> notices = jdbc.queryForList(
                "SELECT id, title, notice_date FROM notice_master ORDER BY id DESC LIMIT 10");
            return ResponseEntity.ok(notices);
        } catch (Exception e) {
            return ResponseEntity.ok(Collections.emptyList());
        }
    }
}
