package com.example.lms.exam.repository;

import com.example.lms.exam.model.Exam;
import com.example.lms.exam.model.ExamResult;
import com.example.lms.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExamResultRepository extends JpaRepository<ExamResult, Integer> {
    List<ExamResult> findByStudent(User student);
    List<ExamResult> findByExam(Exam exam);
    Optional<ExamResult> findByStudentAndExam(User student, Exam exam);
}
