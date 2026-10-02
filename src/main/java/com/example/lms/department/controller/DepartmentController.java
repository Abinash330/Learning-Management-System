package com.example.lms.department.controller;

import com.example.lms.department.model.Department;
import com.example.lms.department.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DepartmentController {

    private final DepartmentService departmentService;

    @Autowired
    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @GetMapping("/admin-departments")
    public String adminDepartments(Model model) {
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "admin/departments";
    }

    @PostMapping("/admin-departments/add")
    public String adminDepartmentsAdd(
            @RequestParam("name") String name,
            @RequestParam("description") String description) {
        Department d = new Department();
        d.setName(name);
        d.setDescription(description);
        departmentService.saveDepartment(d);
        return "redirect:/admin-departments";
    }

    @PostMapping("/admin-departments/delete")
    public String adminDepartmentsDelete(@RequestParam("id") int id) {
        departmentService.deleteDepartmentById(id);
        return "redirect:/admin-departments";
    }
}
