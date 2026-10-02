package com.example.lms.exam.repository;

import com.example.lms.exam.model.ExamResult;
import com.example.lms.exam.model.StudentAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentAnswerRepository extends JpaRepository<StudentAnswer, Integer> {
    List<StudentAnswer> findByExamResult(ExamResult examResult);
}
