package com.example.lms.faculty.service;

import com.example.lms.faculty.dto.FacultyDashboardDTO;
import com.example.lms.user.model.User;

public interface FacultyService {
    FacultyDashboardDTO getFacultyDashboard(User faculty);
}
