package com.example.lms.exam.repository;

import com.example.lms.exam.model.Exam;
import com.example.lms.exam.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {
    List<Question> findByExam(Exam exam);
}
