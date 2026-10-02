package com.example.lms.faq.service;

import com.example.lms.faq.model.FAQ;
import java.util.List;
import java.util.Optional;

public interface FAQService {
    List<FAQ> getAllFAQs();
    List<FAQ> getFAQsForRole(String role);
    Optional<FAQ> getFAQById(Integer id);
    FAQ saveFAQ(FAQ faq);
    void deleteFAQ(Integer id);
}
