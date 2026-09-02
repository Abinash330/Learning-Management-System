package com.example.lms.repository;

import com.example.lms.model.Exam;
import com.example.lms.model.Course;
import com.example.lms.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ExamRepository extends JpaRepository<Exam, Integer> {
    List<Exam> findByCourse(Course course);
    List<Exam> findByFaculty(User faculty);
    List<Exam> findByCourseInAndStatus(List<Course> courses, String status);
}
