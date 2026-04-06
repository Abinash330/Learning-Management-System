package com.example.lms.repository;

import com.example.lms.model.Course;
import com.example.lms.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CourseRepository extends JpaRepository<Course, Integer> {
    List<Course> findByInstructor(User instructor);
    List<Course> findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(String title, String description);
    List<Course> findByTitleContainingOrDescriptionContaining(String title, String description);
}
