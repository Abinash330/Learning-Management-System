package com.example.lms;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {

    @GetMapping("/adashboard")
    public String adashboard(Model model) {
        List<Map<String, Object>> li = jdbc.queryForList("select * from user_master ORDER BY email ASC");
        model.addAttribute("users_master", li);
        
        try {
            // --- Stat Cards ---
            Integer activeUsersCount = jdbc.queryForObject("SELECT COUNT(*) FROM user_master WHERE status = 1", Integer.class);
            Integer facultyCount = jdbc.queryForObject("SELECT COUNT(*) FROM user_master WHERE role = 'Faculty'", Integer.class);
            Integer studentCount = jdbc.queryForObject("SELECT COUNT(*) FROM user_master WHERE role = 'Student'", Integer.class);
            Integer pendingCount  = jdbc.queryForObject("SELECT COUNT(*) FROM user_master WHERE status = 0", Integer.class);
            Integer totalUsers    = jdbc.queryForObject("SELECT COUNT(*) FROM user_master", Integer.class);

            model.addAttribute("activeUsersCount", activeUsersCount != null ? activeUsersCount : 0);
            model.addAttribute("facultyCount",     facultyCount     != null ? facultyCount     : 0);
            model.addAttribute("studentCount",     studentCount     != null ? studentCount     : 0);
            model.addAttribute("pendingCount",     pendingCount     != null ? pendingCount     : 0);
            model.addAttribute("totalUsers",       totalUsers       != null ? totalUsers       : 0);

            // --- Total Courses ---
            try {
                Integer totalCourses = jdbc.queryForObject("SELECT COUNT(*) FROM courses", Integer.class);
                model.addAttribute("totalCourses", totalCourses != null ? totalCourses : 0);
            } catch (Exception e) {
                model.addAttribute("totalCourses", 0);
            }

            // --- Total Enrollments ---
            try {
                Integer totalEnrollments = jdbc.queryForObject("SELECT COUNT(*) FROM enrollments", Integer.class);
                model.addAttribute("totalEnrollments", totalEnrollments != null ? totalEnrollments : 0);
            } catch (Exception e) {
                model.addAttribute("totalEnrollments", 0);
            }

            // --- Recent Users (Activity Feed) ---
            List<Map<String, Object>> recentUsers = jdbc.queryForList(
                "SELECT name, email, role, status FROM user_master ORDER BY id DESC LIMIT 6");
            model.addAttribute("recentUsers", recentUsers);

            // --- Role Stats for Chart.js ---
            Integer adminCount = jdbc.queryForObject("SELECT COUNT(*) FROM user_master WHERE role = 'Admin'", Integer.class);
            model.addAttribute("adminCount",   adminCount   != null ? adminCount   : 0);

            // --- Recent Notices ---
            try {
                List<Map<String, Object>> recentNotices = jdbc.queryForList(
                    "SELECT title, description, notice_date FROM notice_master ORDER BY notice_date DESC LIMIT 4");
                model.addAttribute("recentNotices", recentNotices);
            } catch (Exception e) {
                model.addAttribute("recentNotices", java.util.Collections.emptyList());
            }

            // --- Recent Contact Messages ---
            try {
                List<Map<String, Object>> recentContacts = jdbc.queryForList(
                    "SELECT name, email, subject, message FROM contact ORDER BY id DESC LIMIT 4");
                model.addAttribute("recentContacts", recentContacts);
            } catch (Exception e) {
                model.addAttribute("recentContacts", java.util.Collections.emptyList());
            }

        } catch (Exception e) {
            model.addAttribute("activeUsersCount", 0);
            model.addAttribute("facultyCount", 0);
            model.addAttribute("studentCount", 0);
            model.addAttribute("pendingCount", 0);
            model.addAttribute("totalUsers", 0);
            model.addAttribute("totalCourses", 0);
            model.addAttribute("totalEnrollments", 0);
            model.addAttribute("adminCount", 0);
            model.addAttribute("recentUsers", java.util.Collections.emptyList());
            model.addAttribute("recentNotices", java.util.Collections.emptyList());
            model.addAttribute("recentContacts", java.util.Collections.emptyList());
        }
        
        return "adashboard";
    }

    @PostMapping("/adashboard")
    public String adashboard_manage(Model model, @RequestParam("btn") String btn,
            @RequestParam("email") String email) {
        if (btn.equals("delete")) {
            String sql = "delete from user_master where email=?";
            jdbc.update(sql, email);
            return adashboard(model);
        }
        if (btn.equals("activate")) {
            String sql = "update user_master set status=1 where email=?";
            jdbc.update(sql, email);
            return adashboard(model);
        }
        if (btn.equals("deactivate")) {
            String sql = "update user_master set status=0 where email=?";
            jdbc.update(sql, email);
            return adashboard(model);
        }
        return adashboard(model);
    }

    @PostMapping("/admin-add")
    public String admin_add(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("role") String role,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            Model model) {

        jdbc.execute("INSERT INTO user_master(name,email,mobile,password,role,status,is_online) VALUES('"
                + name + "','"
                + email + "','"
                + mobile + "','"
                + password + "','"
                + role + "','1','0')");

        return adashboard(model);
    }

    @Autowired
    JdbcTemplate jdbc;

    @GetMapping("/users")
    public String users(Model model) {
        List<Map<String, Object>> li = jdbc.queryForList("select * from user_master");
        model.addAttribute("users_master", li);
        return "users";
    }

    @PostMapping("/users")
    public String users_manage(Model model, @RequestParam("btn") String btn,
            @RequestParam("email") String email) {
        if (btn.equals("delete")) {
            String sql = "delete from user_master where email=?";
            jdbc.update(sql, email);
            return users(model);
        }
        if (btn.equals("edit")) {
            List<Map<String, Object>> li = jdbc.queryForList("select * from user_master where email='" + email + "'");
            model.addAttribute("users_master", li);
            return "edituser";
        }
        return users(model);
    }

    @PostMapping("/updateusers")
    public String updateusers(@RequestParam("email") String email, @RequestParam("name") String name,
            @RequestParam("role") String role,
            @RequestParam("mobile") String mobile, Model model) {
        String sql = "update user_master set name=? , role=? , mobile=? where email=?";
        jdbc.update(sql, name, role, mobile, email);
        return users(model);
    }

    @GetMapping("/addnotice")
    public String addnotice() {
        return "addnotice";
    }

    @PostMapping("/addnotice")
    public String addnotice_save(@RequestParam("title") String title, @RequestParam("description") String description,
            Model model) {
        String sql = "INSERT INTO notice_master(title, description, notice_date) VALUES(?, ?, ?)";
        jdbc.update(sql, title, description, LocalDate.now());
        model.addAttribute("message", "Notice published successfully!");
        return "addnotice";
    }
}
