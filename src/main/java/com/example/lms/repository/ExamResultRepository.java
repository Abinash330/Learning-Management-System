package com.example.lms.repository;

import com.example.lms.model.ExamResult;
import com.example.lms.model.Exam;
import com.example.lms.model.User;
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
