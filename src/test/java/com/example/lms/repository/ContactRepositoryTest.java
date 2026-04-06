package com.example.lms.repository;

import com.example.lms.model.Contact;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class ContactRepositoryTest {

    @Autowired
    private ContactRepository contactRepository;

    @Test
    void shouldSaveAndFindContact() {
        Contact contact = new Contact();
        contact.setName("John Doe");
        contact.setEmail("johndoe@test.com");
        contact.setSubject("Help");
        contact.setMessage("I need help");
        
        Contact saved = contactRepository.save(contact);
        
        Optional<Contact> found = contactRepository.findById(saved.getId());
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("John Doe");
    }
}
