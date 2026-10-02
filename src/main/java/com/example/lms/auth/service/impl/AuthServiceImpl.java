package com.example.lms.auth.service.impl;

import com.example.lms.auth.dto.LoginRequestDTO;
import com.example.lms.auth.dto.RegisterRequestDTO;
import com.example.lms.auth.service.AuthService;
import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;

    @Autowired
    public AuthServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public Optional<User> login(LoginRequestDTO request) {
        Optional<User> optUser = userRepository.findByEmailAndPassword(request.getEmail(), request.getPassword());
        if (optUser.isPresent()) {
            User user = optUser.get();
            if (user.getStatus() != null && user.getStatus() == 1) {
                user.setIsOnline(1);
                userRepository.save(user);
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    @Override
    public User register(RegisterRequestDTO request) {
        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setMobile(request.getMobile());
        user.setPassword(request.getPassword());
        user.setRole(request.getRole());
        user.setStatus(0); // Pending admin approval
        user.setIsOnline(0);
        return userRepository.save(user);
    }

    @Override
    public void logout(String email) {
        if (email != null && !email.isBlank()) {
            userRepository.findByEmail(email).ifPresent(user -> {
                user.setIsOnline(0);
                userRepository.save(user);
            });
        }
    }
}
