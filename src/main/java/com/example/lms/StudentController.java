package com.example.lms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Collections;

@Controller
public class StudentController {

    @Autowired
    private JdbcTemplate jdbc;

    // ── Student Dashboard ─────────────────────────────────────
    @GetMapping("/sdashboard")
    public String sdashboard(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            try {
                Map<String, Object> user = jdbc.queryForMap(
                    "SELECT id, name FROM user_master WHERE email = ?", email);
                int studentId = ((Number) user.get("id")).intValue();
                model.addAttribute("name", user.get("name"));

                // Enrolled course count
                Integer enrolledCount = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM enrollments WHERE student_id = ?", Integer.class, studentId);
                model.addAttribute("enrolledCount", enrolledCount != null ? enrolledCount : 0);

                // Completed count (progress = 100)
                Integer completedCount = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND progress = 100", Integer.class, studentId);
                model.addAttribute("completedCount", completedCount != null ? completedCount : 0);

                // Enrolled courses with progress
                List<Map<String, Object>> enrolledCourses = jdbc.queryForList(
                    "SELECT c.id, c.title, c.description, e.progress FROM courses c " +
                    "JOIN enrollments e ON c.id = e.course_id WHERE e.student_id = ?", studentId);
                model.addAttribute("enrolledCourses", enrolledCourses);

                // Pending assignments for this student
                Integer pendingAssignments = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM assignments a " +
                    "JOIN enrollments e ON a.course_id = e.course_id " +
                    "WHERE e.student_id = ? AND a.id NOT IN " +
                    "(SELECT assignment_id FROM assignment_submissions WHERE student_id = ?)",
                    Integer.class, studentId, studentId);
                model.addAttribute("pendingAssignments", pendingAssignments != null ? pendingAssignments : 0);

                // Latest notices
                List<Map<String, Object>> notices = jdbc.queryForList(
                    "SELECT title, notice_date FROM notice_master ORDER BY id DESC LIMIT 3");
                model.addAttribute("notices", notices);

            } catch (Exception e) {
                model.addAttribute("enrolledCount", 0);
                model.addAttribute("completedCount", 0);
                model.addAttribute("pendingAssignments", 0);
            }
        }
        return "sdashboard";
    }

    // ── My Courses with Progress ──────────────────────────────
    @GetMapping("/s-courses")
    public String scourses(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            try {
                Map<String, Object> user = jdbc.queryForMap(
                    "SELECT id FROM user_master WHERE email = ?", email);
                int studentId = ((Number) user.get("id")).intValue();
                List<Map<String, Object>> courses = jdbc.queryForList(
                    "SELECT c.id, c.title, c.description, e.progress, e.id AS enrollment_id " +
                    "FROM courses c JOIN enrollments e ON c.id = e.course_id WHERE e.student_id = ?", studentId);
                model.addAttribute("courses", courses);
            } catch (Exception e) {
                model.addAttribute("courses", Collections.emptyList());
            }
        }
        return "s-courses";
    }

    // ── Update Progress ───────────────────────────────────────
    @PostMapping("/s-update-progress")
    public String updateProgress(
            @RequestParam("course_id") int courseId,
            @RequestParam("progress") int progress,
            Principal principal) {
        if (principal != null) {
            try {
                Map<String, Object> user = jdbc.queryForMap(
                    "SELECT id FROM user_master WHERE email = ?", principal.getName());
                int studentId = ((Number) user.get("id")).intValue();
                int clamp = Math.max(0, Math.min(100, progress));
                jdbc.update(
                    "UPDATE enrollments SET progress = ? WHERE student_id = ? AND course_id = ?",
                    clamp, studentId, courseId);
            } catch (Exception e) { /* log */ }
        }
        return "redirect:/s-courses";
    }

    // ── Student Assignments ───────────────────────────────────
    @GetMapping("/s-assignments")
    public String sassignments(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            try {
                Map<String, Object> user = jdbc.queryForMap(
                    "SELECT id FROM user_master WHERE email = ?", email);
                int studentId = ((Number) user.get("id")).intValue();

                // All assignments for enrolled courses
                List<Map<String, Object>> assignments = jdbc.queryForList(
                    "SELECT a.*, c.title AS course_title, " +
                    "(SELECT id FROM assignment_submissions s WHERE s.assignment_id = a.id AND s.student_id = ?) AS submission_id, " +
                    "(SELECT status FROM assignment_submissions s WHERE s.assignment_id = a.id AND s.student_id = ?) AS sub_status, " +
                    "(SELECT marks FROM assignment_submissions s WHERE s.assignment_id = a.id AND s.student_id = ?) AS marks " +
                    "FROM assignments a JOIN courses c ON a.course_id = c.id " +
                    "JOIN enrollments e ON e.course_id = a.course_id " +
                    "WHERE e.student_id = ? ORDER BY a.due_date ASC",
                    studentId, studentId, studentId, studentId);
                model.addAttribute("assignments", assignments);

            } catch (Exception e) {
                model.addAttribute("assignments", Collections.emptyList());
            }
        }
        return "s-assignments";
    }

    // ── Submit Assignment ─────────────────────────────────────
    @PostMapping("/s-submit")
    public String submitAssignment(
            @RequestParam("assignment_id") int assignmentId,
            @RequestParam("answer") String answer,
            Principal principal) {
        if (principal != null) {
            try {
                Map<String, Object> user = jdbc.queryForMap(
                    "SELECT id FROM user_master WHERE email = ?", principal.getName());
                int studentId = ((Number) user.get("id")).intValue();
                // Check if already submitted — update if so, insert if not
                List<Map<String, Object>> existing = jdbc.queryForList(
                    "SELECT id FROM assignment_submissions WHERE assignment_id=? AND student_id=?",
                    assignmentId, studentId);
                if (existing.isEmpty()) {
                    jdbc.update(
                        "INSERT INTO assignment_submissions (assignment_id, student_id, answer) VALUES (?,?,?)",
                        assignmentId, studentId, answer);
                } else {
                    jdbc.update(
                        "UPDATE assignment_submissions SET answer=?, submitted_at=NOW(), status='submitted' WHERE assignment_id=? AND student_id=?",
                        answer, assignmentId, studentId);
                }
            } catch (Exception e) { /* log */ }
        }
        return "redirect:/s-assignments";
    }

    // ── Global Search ─────────────────────────────────────────
    @GetMapping("/s-search")
    public String ssearch(@RequestParam(name = "q", required = false, defaultValue = "") String query,
                          Model model, Principal principal) {
        String param = "%" + query + "%";
        try {
            List<Map<String, Object>> courses = jdbc.queryForList(
                "SELECT * FROM courses WHERE title LIKE ? OR description LIKE ?", param, param);
            model.addAttribute("courses", courses);
        } catch (Exception e) {
            model.addAttribute("courses", Collections.emptyList());
        }
        try {
            List<Map<String, Object>> notices = jdbc.queryForList(
                "SELECT * FROM notice_master WHERE title LIKE ? OR description LIKE ? ORDER BY id DESC",
                param, param);
            model.addAttribute("notices", notices);
        } catch (Exception e) {
            model.addAttribute("notices", Collections.emptyList());
        }
        model.addAttribute("query", query);
        return "s-search";
    }

    // ── Start Course ──────────────────────────────────────────
    @GetMapping("/s-start-course")
    public String sstartcourse(@RequestParam(name = "id", required = false, defaultValue = "0") int courseId,
                               Model model, Principal principal) {
        if (courseId > 0) {
            try {
                Map<String, Object> course = jdbc.queryForMap("SELECT * FROM courses WHERE id=?", courseId);
                model.addAttribute("course", course);
            } catch (Exception e) { /* not found */ }
        }
        return "s-start-course";
    }

    // ── Premium Page ──────────────────────────────────────────
    @GetMapping("/s-premium")
    public String spremium() { return "s-premium"; }

    // ── Profile Page ──────────────────────────────────────────
    @GetMapping("/s-profile")
    public String sprofile(Model model, Principal principal) {
        if (principal != null) {
            String email = principal.getName();
            try {
                Map<String, Object> user = jdbc.queryForMap("SELECT * FROM user_master WHERE email = ?", email);
                model.addAttribute("user", user);
                model.addAttribute("name", user.get("name"));
            } catch (Exception e) { /* log */ }
        }
        return "s-profile";
    }
}