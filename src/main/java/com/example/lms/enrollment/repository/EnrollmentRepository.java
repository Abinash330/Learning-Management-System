package com.example.lms.enrollment.repository;

import com.example.lms.course.model.Course;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Integer> {
    List<Enrollment> findByStudent(User student);
    Long countByStudent(User student);
    Long countByStudentAndProgress(User student, Integer progress);
    Long countByCourse(Course course);
    Optional<Enrollment> findByStudentAndCourse(User student, Course course);
}
