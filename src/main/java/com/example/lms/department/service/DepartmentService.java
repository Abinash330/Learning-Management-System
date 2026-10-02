package com.example.lms.department.service;

import com.example.lms.department.model.Department;
import java.util.List;
import java.util.Optional;

public interface DepartmentService {
    List<Department> getAllDepartments();
    Optional<Department> getDepartmentById(Integer id);
    Department saveDepartment(Department department);
    void deleteDepartmentById(Integer id);
}
