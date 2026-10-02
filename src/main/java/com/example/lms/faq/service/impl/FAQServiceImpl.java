package com.example.lms.faq.service.impl;

import com.example.lms.faq.model.FAQ;
import com.example.lms.faq.repository.FAQRepository;
import com.example.lms.faq.service.FAQService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class FAQServiceImpl implements FAQService {

    private final FAQRepository faqRepository;

    @Autowired
    public FAQServiceImpl(FAQRepository faqRepository) {
        this.faqRepository = faqRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<FAQ> getAllFAQs() {
        return faqRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<FAQ> getFAQsForRole(String role) {
        List<String> roles = new ArrayList<>();
        roles.add("All");
        if (role != null && !role.isBlank()) {
            roles.add(role);
        }
        return faqRepository.findByRoleIn(roles);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<FAQ> getFAQById(Integer id) {
        return faqRepository.findById(id);
    }

    @Override
    public FAQ saveFAQ(FAQ faq) {
        return faqRepository.save(faq);
    }

    @Override
    public void deleteFAQ(Integer id) {
        faqRepository.deleteById(id);
    }
}
