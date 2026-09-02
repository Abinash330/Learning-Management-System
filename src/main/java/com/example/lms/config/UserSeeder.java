package com.example.lms.config;

import com.example.lms.model.User;
import com.example.lms.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Configuration
public class UserSeeder {

    @Bean
    CommandLineRunner initUsers(UserRepository userRepository) {
        return args -> {
            if (userRepository.findByEmail("admin@lms.com").isEmpty()) {
                User admin = new User();
                admin.setName("Master Admin");
                admin.setEmail("admin@lms.com");
                admin.setPassword("admin123");
                admin.setRole("Admin");
                admin.setStatus(1);
                admin.setMobile("9876543210");
                userRepository.save(admin);
                System.out.println("✅ UserSeeder: Admin user created.");
            }

            if (userRepository.findByEmail("faculty@lms.com").isEmpty()) {
                User faculty = new User();
                faculty.setName("Dr. Smith");
                faculty.setEmail("faculty@lms.com");
                faculty.setPassword("faculty123");
                faculty.setRole("Faculty");
                faculty.setStatus(1);
                faculty.setMobile("9876543211");
                userRepository.save(faculty);
                System.out.println("✅ UserSeeder: Faculty user created.");
            }

            if (userRepository.findByEmail("student@lms.com").isEmpty()) {
                User student = new User();
                student.setName("Alex Johnson");
                student.setEmail("student@lms.com");
                student.setPassword("student123");
                student.setRole("Student");
                student.setStatus(1);
                student.setMobile("9876543212");
                userRepository.save(student);
                System.out.println("✅ UserSeeder: Student user created.");
            }
        };
    }
}
