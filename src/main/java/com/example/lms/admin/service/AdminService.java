package com.example.lms.admin.service;

import com.example.lms.admin.dto.AdminDashboardDTO;
import com.example.lms.user.model.User;

public interface AdminService {
    AdminDashboardDTO getDashboardData();
    User createAdminUser(String name, String email, String role, String mobile, String password);
}
