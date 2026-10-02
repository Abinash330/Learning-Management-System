package com.example.lms.exam.repository;

import com.example.lms.exam.model.Option;
import com.example.lms.exam.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OptionRepository extends JpaRepository<Option, Integer> {
    List<Option> findByQuestion(Question question);
}
