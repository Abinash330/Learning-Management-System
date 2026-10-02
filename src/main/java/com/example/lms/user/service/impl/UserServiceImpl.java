package com.example.lms.user.service.impl;

import com.example.lms.common.exception.ResourceNotFoundException;
import com.example.lms.user.dto.UserProfileUpdateDTO;
import com.example.lms.user.dto.UserRegistrationDTO;
import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import com.example.lms.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers(Sort sort) {
        return userRepository.findAll(sort);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> getUserById(Integer id) {
        return userRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> authenticate(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password);
    }

    @Override
    public User registerUser(UserRegistrationDTO dto) {
        User user = new User();
        user.setName(dto.getName());
        user.setEmail(dto.getEmail());
        user.setMobile(dto.getMobile());
        user.setPassword(dto.getPassword());
        user.setRole(dto.getRole());
        user.setStatus(0); // Pending approval
        user.setIsOnline(0);
        return userRepository.save(user);
    }

    @Override
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public User updateUser(Integer id, String name, String role, String mobile) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + id));
        user.setName(name);
        user.setRole(role);
        user.setMobile(mobile);
        return userRepository.save(user);
    }

    @Override
    public User updateUserProfile(String email, UserProfileUpdateDTO dto) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + email));
        if (dto.getName() != null && !dto.getName().isBlank()) {
            user.setName(dto.getName().trim());
        }
        if (dto.getMobile() != null && !dto.getMobile().isBlank()) {
            user.setMobile(dto.getMobile().trim());
        }
        return userRepository.save(user);
    }

    @Override
    public void setUserOnlineStatus(String email, int isOnline) {
        userRepository.findByEmail(email).ifPresent(user -> {
            user.setIsOnline(isOnline);
            userRepository.save(user);
        });
    }

    @Override
    public void setUserStatus(String email, int status) {
        userRepository.findByEmail(email).ifPresent(user -> {
            user.setStatus(status);
            userRepository.save(user);
        });
    }

    @Override
    public void deleteUserByEmail(String email) {
        userRepository.findByEmail(email).ifPresent(userRepository::delete);
    }

    @Override
    public void deleteUserById(Integer id) {
        userRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getUsersByStatus(Integer status) {
        return userRepository.findByStatus(status);
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getUsersByRole(String role) {
        return userRepository.findByRoleIgnoreCase(role);
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getUsersByRoleAndStatus(String role, Integer status) {
        return userRepository.findByRoleIgnoreCaseAndStatus(role, status);
    }

    @Override
    @Transactional(readOnly = true)
    public long countUsers() {
        return userRepository.count();
    }
}
