package com.example.lms.contact.service;

import com.example.lms.contact.model.Contact;
import org.springframework.data.domain.Sort;

import java.util.List;

public interface ContactService {
    List<Contact> getAllContacts();
    List<Contact> getAllContacts(Sort sort);
    Contact saveContact(Contact contact);
    Contact saveContact(String name, String email, String mobile, String subject, String message);
}
