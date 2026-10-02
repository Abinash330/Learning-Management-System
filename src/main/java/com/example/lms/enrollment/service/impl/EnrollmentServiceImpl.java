package com.example.lms.enrollment.service.impl;

import com.example.lms.course.model.Course;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.enrollment.repository.EnrollmentRepository;
import com.example.lms.enrollment.service.EnrollmentService;
import com.example.lms.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class EnrollmentServiceImpl implements EnrollmentService {

    private final EnrollmentRepository enrollmentRepository;

    @Autowired
    public EnrollmentServiceImpl(EnrollmentRepository enrollmentRepository) {
        this.enrollmentRepository = enrollmentRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Enrollment> getEnrollmentsByStudent(User student) {
        return enrollmentRepository.findByStudent(student);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Enrollment> getEnrollmentByStudentAndCourse(User student, Course course) {
        return enrollmentRepository.findByStudentAndCourse(student, course);
    }

    @Override
    public Enrollment enrollStudent(User student, Course course) {
        Optional<Enrollment> existing = enrollmentRepository.findByStudentAndCourse(student, course);
        if (existing.isPresent()) {
            return existing.get();
        }
        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student);
        enrollment.setCourse(course);
        enrollment.setProgress(0);
        return enrollmentRepository.save(enrollment);
    }

    @Override
    public Enrollment updateProgress(Enrollment enrollment, int progress) {
        enrollment.setProgress(progress);
        return enrollmentRepository.save(enrollment);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByStudent(User student) {
        return enrollmentRepository.countByStudent(student);
    }

    @Override
    @Transactional(readOnly = true)
    public long countCompletedByStudent(User student) {
        return enrollmentRepository.countByStudentAndProgress(student, 100);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByCourse(Course course) {
        return enrollmentRepository.countByCourse(course);
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalEnrollments() {
        return enrollmentRepository.count();
    }
}
