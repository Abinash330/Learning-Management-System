package com.example.lms.student.service;

import com.example.lms.student.dto.StudentDashboardDTO;
import com.example.lms.user.model.User;

public interface StudentService {
    StudentDashboardDTO getStudentDashboard(User student);
}
