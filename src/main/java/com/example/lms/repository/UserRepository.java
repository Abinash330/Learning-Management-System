package com.example.lms.repository;

import com.example.lms.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmailAndPassword(String email, String password);
    Optional<User> findByEmail(String email);
    List<User> findByRole(String role);
    List<User> findByRoleIgnoreCase(String role);
    List<User> findByRoleAndStatus(String role, Integer status);
    List<User> findByRoleIgnoreCaseAndStatus(String role, Integer status);
    List<User> findByStatus(Integer status);
}
