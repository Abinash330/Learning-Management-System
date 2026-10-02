package com.example.lms.course.controller;

import com.example.lms.course.service.CourseService;
import com.example.lms.department.service.DepartmentService;
import com.example.lms.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CourseController {

    private final CourseService courseService;
    private final UserService userService;
    private final DepartmentService departmentService;

    @Autowired
    public CourseController(CourseService courseService,
                            UserService userService,
                            DepartmentService departmentService) {
        this.courseService = courseService;
        this.userService = userService;
        this.departmentService = departmentService;
    }

    @GetMapping("/admin-courses")
    public String adminCourses(Model model) {
        model.addAttribute("courses", courseService.getAllCourses());
        model.addAttribute("facultyList", userService.getUsersByRoleAndStatus("Faculty", 1));
        model.addAttribute("departmentList", departmentService.getAllDepartments());
        return "admin/courses";
    }

    @PostMapping("/admin-courses/delete")
    public String adminCoursesDelete(@RequestParam("id") int id) {
        courseService.deleteCourseById(id);
        return "redirect:/admin-courses";
    }

    @PostMapping("/admin-courses/add")
    public String adminCoursesAdd(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("instructor_id") int instructorId,
            @RequestParam(value = "department_id", required = false) Integer departmentId) {
        courseService.createCourse(title, description, instructorId, departmentId);
        return "redirect:/admin-courses";
    }
}
