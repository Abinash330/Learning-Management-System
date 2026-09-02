package com.example.lms.config;

import com.example.lms.model.Notice;
import com.example.lms.model.User;
import com.example.lms.repository.NoticeRepository;
import com.example.lms.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.util.Optional;

@Configuration
public class NoticeSeeder {

    @Bean
    CommandLineRunner initNotices(NoticeRepository noticeRepository,
                                  UserRepository userRepository) {
        return args -> {
            // We'll clear existing notices for a fresh test state if requested, 
            // but for now let's just add if empty to avoid data loss.
            if (noticeRepository.count() == 0) {

                User admin = userRepository.findByEmail("admin@lms.com").orElse(null);
                User faculty = userRepository.findByEmail("faculty@lms.com").orElse(null);

                // 1. General Notice
                noticeRepository.save(new Notice(null, "Annual Sports Meet 2026", 
                    "The annual sports meet is scheduled for May 15-18. All students and faculty are invited to participate.",
                    LocalDate.now(), "ALL", null, null, admin));

                // 2. Student Specific Notice
                noticeRepository.save(new Notice(null, "Exam Schedule Released", 
                    "Final semester exam schedule for Spring 2026 is now available. Check the downloads for details.",
                    LocalDate.now().minusDays(1), "STUDENT", null, null, admin));

                // 3. Faculty Specific Notice
                noticeRepository.save(new Notice(null, "Staff Coordination Meeting", 
                    "A mandatory meeting for all faculty members will be held in the conference hall this Friday at 4 PM.",
                    LocalDate.now().minusDays(2), "FACULTY", null, null, admin));

                // 4. Another Student Notice (from Faculty)
                noticeRepository.save(new Notice(null, "Java Workshop Registration", 
                    "Last date to register for the Java Workshop is April 25. Please register via the link on your portal.",
                    LocalDate.now(), "STUDENT", null, null, faculty));

                // 5. Holiday Notice
                noticeRepository.save(new Notice(null, "Holiday Announcement: Eid-ul-Fitr", 
                    "The institution will remain closed on the occasion of Eid-ul-Fitr. Classes will resume from Monday.",
                    LocalDate.now().plusDays(2), "ALL", null, null, admin));

                System.out.println("✅ NoticeSeeder: Sample notices inserted.");
            }
        };
    }
}
