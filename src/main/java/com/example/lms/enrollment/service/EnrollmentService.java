package com.example.lms.enrollment.service;

import com.example.lms.course.model.Course;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.user.model.User;

import java.util.List;
import java.util.Optional;

public interface EnrollmentService {
    List<Enrollment> getEnrollmentsByStudent(User student);
    Optional<Enrollment> getEnrollmentByStudentAndCourse(User student, Course course);
    Enrollment enrollStudent(User student, Course course);
    Enrollment updateProgress(Enrollment enrollment, int progress);
    long countByStudent(User student);
    long countCompletedByStudent(User student);
    long countByCourse(Course course);
    long countTotalEnrollments();
}
