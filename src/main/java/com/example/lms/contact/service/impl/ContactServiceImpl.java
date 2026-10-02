package com.example.lms.contact.service.impl;

import com.example.lms.contact.model.Contact;
import com.example.lms.contact.repository.ContactRepository;
import com.example.lms.contact.service.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ContactServiceImpl implements ContactService {

    private final ContactRepository contactRepository;

    @Autowired
    public ContactServiceImpl(ContactRepository contactRepository) {
        this.contactRepository = contactRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Contact> getAllContacts() {
        return contactRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Contact> getAllContacts(Sort sort) {
        return contactRepository.findAll(sort);
    }

    @Override
    public Contact saveContact(Contact contact) {
        return contactRepository.save(contact);
    }

    @Override
    public Contact saveContact(String name, String email, String mobile, String subject, String message) {
        Contact c = new Contact();
        c.setName(name);
        c.setEmail(email);
        c.setMobile(mobile);
        c.setSubject(subject);
        c.setMessage(message);
        return contactRepository.save(c);
    }
}
