package com.example.lms.faq.repository;

import com.example.lms.faq.model.FAQ;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FAQRepository extends JpaRepository<FAQ, Integer> {
    List<FAQ> findByRoleIn(List<String> roles);
}
