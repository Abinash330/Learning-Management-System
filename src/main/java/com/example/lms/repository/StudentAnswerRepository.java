package com.example.lms.repository;

import com.example.lms.model.ExamResult;
import com.example.lms.model.StudentAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudentAnswerRepository extends JpaRepository<StudentAnswer, Integer> {
    List<StudentAnswer> findByExamResult(ExamResult examResult);
}
