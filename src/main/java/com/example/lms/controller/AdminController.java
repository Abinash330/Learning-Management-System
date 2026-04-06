package com.example.lms.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.data.domain.Sort;

import com.example.lms.model.Course;
import com.example.lms.model.Notice;
import com.example.lms.model.User;
import com.example.lms.repository.ContactRepository;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.EnrollmentRepository;
import com.example.lms.repository.NoticeRepository;
import com.example.lms.repository.UserRepository;

@Controller
public class AdminController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private NoticeRepository noticeRepository;
    @Autowired
    private ContactRepository contactRepository;

    @GetMapping("/adashboard")
    public String adashboard(Model model) {
        List<User> li = userRepository.findAll(Sort.by(Sort.Direction.ASC, "email"));
        model.addAttribute("users_master", li);
        
        try {
            long activeUsersCount = userRepository.findByStatus(1).size();
            long facultyCount = userRepository.findByRoleIgnoreCase("Faculty").size();
            long studentCount = userRepository.findByRoleIgnoreCase("Student").size();
            long pendingCount  = userRepository.findByStatus(0).size();
            long totalUsers = userRepository.count();

            model.addAttribute("activeUsersCount", activeUsersCount);
            model.addAttribute("facultyCount", facultyCount);
            model.addAttribute("studentCount", studentCount);
            model.addAttribute("pendingCount", pendingCount);
            model.addAttribute("totalUsers", totalUsers);

            long totalCourses = courseRepository.count();
            model.addAttribute("totalCourses", totalCourses);

            long totalEnrollments = enrollmentRepository.count();
            model.addAttribute("totalEnrollments", totalEnrollments);

            int activeUsersPct = (totalUsers > 0) ? (int)((activeUsersCount / (double)totalUsers) * 100) : 0;
            int pendingUsersPct = (totalUsers > 0) ? (int)((pendingCount / (double)totalUsers) * 100) : 0;
            int enrolledPct = (totalUsers > 0) ? (int)(((double)totalEnrollments / (totalUsers * 2)) * 100) : 0;
            if(enrolledPct > 100) enrolledPct = 100;
            int coursesPct = (totalCourses > 0) ? (int)(((double)totalCourses / 50) * 100) : 0; 
            if(coursesPct > 100) coursesPct = 100;

            model.addAttribute("activeUsersPct", activeUsersPct);
            model.addAttribute("pendingUsersPct", pendingUsersPct);
            model.addAttribute("enrolledPct", enrolledPct);
            model.addAttribute("coursesPct", coursesPct);

            List<User> recentUsers = userRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
            if(recentUsers.size() > 6) recentUsers = recentUsers.subList(0, 6);
            model.addAttribute("recentUsers", recentUsers);

            long adminCount = userRepository.findByRoleIgnoreCase("Admin").size();
            model.addAttribute("adminCount", adminCount);

            model.addAttribute("recentNotices", noticeRepository.findTop4ByOrderByNoticeDateDesc());

            var recentContacts = contactRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
            if(recentContacts.size() > 4) recentContacts = recentContacts.subList(0, 4);
            model.addAttribute("recentContacts", recentContacts);

        } catch (Exception e) {
            model.addAttribute("activeUsersCount", 0);
            model.addAttribute("facultyCount", 0);
            model.addAttribute("studentCount", 0);
            model.addAttribute("pendingCount", 0);
            model.addAttribute("totalUsers", 0);
            model.addAttribute("totalCourses", 0);
            model.addAttribute("totalEnrollments", 0);
            model.addAttribute("adminCount", 0);
            model.addAttribute("activeUsersPct", 0);
            model.addAttribute("pendingUsersPct", 0);
            model.addAttribute("enrolledPct", 0);
            model.addAttribute("coursesPct", 0);
            model.addAttribute("recentUsers", java.util.Collections.emptyList());
            model.addAttribute("recentNotices", java.util.Collections.emptyList());
            model.addAttribute("recentContacts", java.util.Collections.emptyList());
        }
        
        return "adashboard";
    }

    @PostMapping("/adashboard")
    public String adashboard_manage(Model model, @RequestParam("btn") String btn,
            @RequestParam("email") String email) {
        Optional<User> uOpt = userRepository.findByEmail(email);
        if (uOpt.isPresent()) {
            User u = uOpt.get();
            if (btn.equals("delete")) {
                userRepository.delete(u);
            } else if (btn.equals("activate")) {
                u.setStatus(1);
                userRepository.save(u);
            } else if (btn.equals("deactivate")) {
                u.setStatus(0);
                userRepository.save(u);
            }
        }
        return "redirect:/adashboard";
    }

    @PostMapping("/admin-add")
    public String admin_add(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("role") String role,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            Model model) {

        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setMobile(mobile);
        u.setPassword(password);
        u.setRole(role);
        u.setStatus(1);
        u.setIsOnline(0);
        userRepository.save(u);

        return "redirect:/adashboard";
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users_master", userRepository.findAll());
        return "users";
    }

    @PostMapping("/users")
    public String users_manage(Model model, @RequestParam("btn") String btn,
            @RequestParam("email") String email) {
        Optional<User> uOpt = userRepository.findByEmail(email);
        if (uOpt.isPresent()) {
            User u = uOpt.get();
            if (btn.equals("delete")) {
                userRepository.delete(u);
            } else if (btn.equals("edit")) {
                model.addAttribute("users_master", List.of(u));
                return "edituser";
            }
        }
        return "redirect:/users";
    }

    @PostMapping("/updateusers")
    public String updateusers(@RequestParam("email") String email, @RequestParam("name") String name,
            @RequestParam("role") String role,
            @RequestParam("mobile") String mobile, Model model) {
        Optional<User> uOpt = userRepository.findByEmail(email);
        if (uOpt.isPresent()) {
            User u = uOpt.get();
            u.setName(name);
            u.setRole(role);
            u.setMobile(mobile);
            userRepository.save(u);
        }
        return "redirect:/users";
    }

    @GetMapping("/addnotice")
    public String addnotice() {
        return "addnotice";
    }

    @PostMapping("/addnotice")
    public String addnotice_save(@RequestParam("title") String title, @RequestParam("description") String description,
            Model model) {
        Notice n = new Notice();
        n.setTitle(title);
        n.setDescription(description);
        n.setNoticeDate(LocalDate.now());
        noticeRepository.save(n);
        model.addAttribute("message", "Notice published successfully!");
        return "addnotice";
    }

    @GetMapping("/admin-courses")
    public String adminCourses(Model model) {
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("facultyList", userRepository.findByRoleIgnoreCaseAndStatus("Faculty", 1));
        return "admin-courses";
    }

    @PostMapping("/admin-courses/delete")
    public String adminCoursesDelete(@RequestParam("id") int id) {
        courseRepository.deleteById(id);
        return "redirect:/admin-courses";
    }

    @PostMapping("/admin-courses/add")
    public String adminCoursesAdd(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("instructor_id") int instructorId) {
        Optional<User> instructor = userRepository.findById(instructorId);
        if (instructor.isPresent()) {
            Course c = new Course();
            c.setTitle(title);
            c.setDescription(description);
            c.setInstructor(instructor.get());
            courseRepository.save(c);
        }
        return "redirect:/admin-courses";
    }

    @GetMapping("/admin-metrics")
    public String adminMetrics(Model model) {
        try {
            model.addAttribute("totalUsers", userRepository.count());
            model.addAttribute("activeUsers", userRepository.findByStatus(1).size());
            model.addAttribute("totalCourses", courseRepository.count());
            model.addAttribute("totalEnrollments", enrollmentRepository.count());

            // Course stats simplified for now without custom query
            model.addAttribute("courseStats", courseRepository.findAll());

        } catch(Exception e) {}
        return "admin-metrics";
    }
}
