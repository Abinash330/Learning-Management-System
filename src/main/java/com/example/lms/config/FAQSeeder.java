package com.example.lms.config;

import com.example.lms.model.FAQ;
import com.example.lms.repository.FAQRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Configuration
public class FAQSeeder {

    @Bean
    CommandLineRunner initFAQ(FAQRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                repository.saveAll(Arrays.asList(
                    // General FAQs
                    new FAQ("What is LMS?", "Learning Management System (LMS) is a comprehensive digital platform designed to bridge the gap between students and educators.", "All", "General"),
                    new FAQ("How do I contact support?", "Our support team is available 24/7. You can reach us via the live chat or by emailing support@lms.com.", "All", "General"),
                    
                    // Student FAQs
                    new FAQ("How can I enroll in a course?", "Navigate to the Course Library, browse categories, and click 'Enroll Now' on any course.", "Student", "Courses"),
                    new FAQ("Can I track my progress?", "Yes, your student dashboard shows real-time progress for all enrolled courses.", "Student", "Dashboard"),
                    new FAQ("How do I submit assignments?", "Go to the specific course page, click on the assignment, and upload your file in the submission section.", "Student", "Assignments"),
                    
                    // Faculty FAQs
                    new FAQ("How do I create a new course?", "Faculty members can use the 'Create Course' button on their dashboard to start building a new course.", "Faculty", "Management"),
                    new FAQ("How can I see student submissions?", "Visit the course management page and click on 'View Submissions' for any active assignment.", "Faculty", "Grading"),
                    new FAQ("How do I post a notice?", "Use the 'Broadcast' feature in your dashboard to send notices to all students in your courses.", "Faculty", "Communication"),
                    
                    // Admin FAQs
                    new FAQ("How do I approve new users?", "In the Admin Dashboard, navigate to 'User Management' and click the approve button for pending users.", "Admin", "User Management"),
                    new FAQ("Can I view system-wide analytics?", "Yes, the main Admin Dashboard provides high-level metrics for courses, users, and enrollments.", "Admin", "Analytics"),
                    new FAQ("How do I manage course categories?", "The 'Course Management' portal allow admins to create, edit, or delete entire course categories.", "Admin", "System Configuration")
                ));
            }
        };
    }
}
