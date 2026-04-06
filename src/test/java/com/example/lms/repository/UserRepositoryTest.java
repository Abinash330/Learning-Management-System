package com.example.lms.repository;

import com.example.lms.model.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class UserRepositoryTest {

    @Autowired
    private UserRepository userRepository;

    @BeforeEach
    void setUp() {
        User user1 = new User();
        user1.setEmail("test@test.com");
        user1.setPassword("password");
        user1.setRole("Student");
        user1.setStatus(1);
        userRepository.save(user1);

        User user2 = new User();
        user2.setEmail("admin@test.com");
        user2.setPassword("adminpass");
        user2.setRole("Admin");
        user2.setStatus(0);
        userRepository.save(user2);
    }

    @AfterEach
    void tearDown() {
        userRepository.deleteAll();
    }

    @Test
    void shouldFindByEmailAndPassword() {
        Optional<User> found = userRepository.findByEmailAndPassword("test@test.com", "password");
        assertThat(found).isPresent();
        assertThat(found.get().getRole()).isEqualTo("Student");
    }

    @Test
    void shouldFindByEmail() {
        Optional<User> found = userRepository.findByEmail("admin@test.com");
        assertThat(found).isPresent();
        assertThat(found.get().getRole()).isEqualTo("Admin");
    }

    @Test
    void shouldFindByRole() {
        List<User> students = userRepository.findByRole("Student");
        assertThat(students).hasSize(1);
        assertThat(students.get(0).getEmail()).isEqualTo("test@test.com");
    }

    @Test
    void shouldFindByRoleAndStatus() {
        List<User> students = userRepository.findByRoleAndStatus("Student", 1);
        assertThat(students).hasSize(1);

        List<User> admins = userRepository.findByRoleAndStatus("Admin", 1);
        assertThat(admins).isEmpty();
    }

    @Test
    void shouldFindByStatus() {
        List<User> activeUsers = userRepository.findByStatus(1);
        assertThat(activeUsers).hasSize(1);
        assertThat(activeUsers.get(0).getEmail()).isEqualTo("test@test.com");

        List<User> inactiveUsers = userRepository.findByStatus(0);
        assertThat(inactiveUsers).hasSize(1);
    }
}
