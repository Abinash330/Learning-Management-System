package com.example.lms.repository;

import com.example.lms.model.Assignment;
import com.example.lms.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AssignmentRepository extends JpaRepository<Assignment, Integer> {
    List<Assignment> findByCourseOrderByCreatedAtDesc(Course course);
    List<Assignment> findByCourse(Course course);
}
