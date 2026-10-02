package com.example.lms.auth.service;

import com.example.lms.auth.dto.LoginRequestDTO;
import com.example.lms.auth.dto.RegisterRequestDTO;
import com.example.lms.user.model.User;

import java.util.Optional;

public interface AuthService {
    Optional<User> login(LoginRequestDTO request);
    User register(RegisterRequestDTO request);
    void logout(String email);
}
