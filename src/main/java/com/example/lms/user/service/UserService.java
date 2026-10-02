package com.example.lms.user.service;

import com.example.lms.user.dto.UserProfileUpdateDTO;
import com.example.lms.user.dto.UserRegistrationDTO;
import com.example.lms.user.model.User;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<User> getAllUsers();
    List<User> getAllUsers(Sort sort);
    Optional<User> getUserById(Integer id);
    Optional<User> getUserByEmail(String email);
    Optional<User> authenticate(String email, String password);
    User registerUser(UserRegistrationDTO dto);
    User saveUser(User user);
    User updateUser(Integer id, String name, String role, String mobile);
    User updateUserProfile(String email, UserProfileUpdateDTO dto);
    void setUserOnlineStatus(String email, int isOnline);
    void setUserStatus(String email, int status);
    void deleteUserByEmail(String email);
    void deleteUserById(Integer id);
    List<User> getUsersByStatus(Integer status);
    List<User> getUsersByRole(String role);
    List<User> getUsersByRoleAndStatus(String role, Integer status);
    long countUsers();
}
