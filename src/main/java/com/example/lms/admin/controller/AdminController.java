package com.example.lms.admin.controller;

import com.example.lms.admin.dto.AdminDashboardDTO;
import com.example.lms.admin.service.AdminService;
import com.example.lms.course.service.CourseService;
import com.example.lms.enrollment.service.EnrollmentService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
public class AdminController {

    private final AdminService adminService;
    private final UserService userService;
    private final CourseService courseService;
    private final EnrollmentService enrollmentService;

    @Autowired
    public AdminController(AdminService adminService,
                           UserService userService,
                           CourseService courseService,
                           EnrollmentService enrollmentService) {
        this.adminService = adminService;
        this.userService = userService;
        this.courseService = courseService;
        this.enrollmentService = enrollmentService;
    }

    @GetMapping("/adashboard")
    public String adashboard(Model model) {
        AdminDashboardDTO dto = adminService.getDashboardData();
        model.addAttribute("users_master", dto.getUsersMaster());
        model.addAttribute("activeUsersCount", dto.getActiveUsersCount());
        model.addAttribute("facultyCount", dto.getFacultyCount());
        model.addAttribute("studentCount", dto.getStudentCount());
        model.addAttribute("pendingCount", dto.getPendingCount());
        model.addAttribute("totalUsers", dto.getTotalUsers());
        model.addAttribute("totalCourses", dto.getTotalCourses());
        model.addAttribute("totalEnrollments", dto.getTotalEnrollments());
        model.addAttribute("adminCount", dto.getAdminCount());
        model.addAttribute("activeUsersPct", dto.getActiveUsersPct());
        model.addAttribute("pendingUsersPct", dto.getPendingUsersPct());
        model.addAttribute("enrolledPct", dto.getEnrolledPct());
        model.addAttribute("coursesPct", dto.getCoursesPct());
        model.addAttribute("recentUsers", dto.getRecentUsers());
        model.addAttribute("recentNotices", dto.getRecentNotices());
        model.addAttribute("recentContacts", dto.getRecentContacts());
        return "admin/dashboard";
    }

    @PostMapping("/adashboard")
    public String adashboardManage(@RequestParam("btn") String btn,
                                   @RequestParam("email") String email) {
        Optional<User> uOpt = userService.getUserByEmail(email);
        if (uOpt.isPresent()) {
            User u = uOpt.get();
            if ("delete".equals(btn)) {
                userService.deleteUserByEmail(email);
            } else if ("activate".equals(btn)) {
                userService.setUserStatus(email, 1);
            } else if ("deactivate".equals(btn)) {
                userService.setUserStatus(email, 0);
            }
        }
        return "redirect:/adashboard";
    }

    @PostMapping("/admin-add")
    public String adminAdd(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("role") String role,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password) {

        adminService.createAdminUser(name, email, role, mobile, password);
        return "redirect:/adashboard";
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users_master", userService.getAllUsers());
        return "admin/users";
    }

    @PostMapping("/users")
    public String usersManage(Model model,
                              @RequestParam("btn") String btn,
                              @RequestParam("email") String email) {
        Optional<User> uOpt = userService.getUserByEmail(email);
        if (uOpt.isPresent()) {
            User u = uOpt.get();
            if ("delete".equals(btn)) {
                userService.deleteUserByEmail(email);
            } else if ("edit".equals(btn)) {
                model.addAttribute("users_master", List.of(u));
                return "admin/edituser";
            }
        }
        return "redirect:/users";
    }

    @PostMapping("/updateusers")
    public String updateUsers(@RequestParam("email") String email,
                              @RequestParam("name") String name,
                              @RequestParam("role") String role,
                              @RequestParam("mobile") String mobile) {
        Optional<User> uOpt = userService.getUserByEmail(email);
        if (uOpt.isPresent()) {
            User u = uOpt.get();
            userService.updateUser(u.getId(), name, role, mobile);
        }
        return "redirect:/users";
    }

    @GetMapping("/admin-metrics")
    public String adminMetrics(Model model) {
        try {
            model.addAttribute("totalUsers", userService.countUsers());
            model.addAttribute("activeUsers", userService.getUsersByStatus(1).size());
            model.addAttribute("totalCourses", courseService.countCourses());
            model.addAttribute("totalEnrollments", enrollmentService.countTotalEnrollments());
            model.addAttribute("courseStats", courseService.getAllCourses());
        } catch (Exception ignored) {}
        return "admin/metrics";
    }
}
