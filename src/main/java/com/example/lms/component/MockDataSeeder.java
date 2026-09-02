package com.example.lms.component;

import com.example.lms.model.*;
import com.example.lms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@ConditionalOnProperty(name = "app.seeder.enabled", havingValue = "true", matchIfMissing = true)
public class MockDataSeeder implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private ExamRepository examRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Override
    public void run(String... args) throws Exception {
        if (examRepository.count() == 0) {
            System.out.println("No exams found in database. Initializing mock data...");

            // 1. Create Users
            User admin = userRepository.findByEmail("admin@example.com").orElseGet(() -> {
                User u = new User();
                u.setName("Admin User");
                u.setEmail("admin@example.com");
                u.setPassword("password"); // Simple for testing
                u.setRole("Admin");
                u.setStatus(1);
                return userRepository.save(u);
            });

            User faculty = userRepository.findByEmail("faculty@example.com").orElseGet(() -> {
                User u = new User();
                u.setName("Faculty User");
                u.setEmail("faculty@example.com");
                u.setPassword("password");
                u.setRole("Faculty");
                u.setStatus(1);
                return userRepository.save(u);
            });

            User student = userRepository.findByEmail("student@example.com").orElseGet(() -> {
                User u = new User();
                u.setName("Student User");
                u.setEmail("student@example.com");
                u.setPassword("password");
                u.setRole("Student");
                u.setStatus(1);
                return userRepository.save(u);
            });

            // 2. Create Course
            Course course = new Course();
            course.setTitle("Introduction to Mock Exams");
            course.setDescription("A dummy course for testing the exam portal.");
            course.setInstructor(faculty);
            course = courseRepository.save(course);

            // 3. Create Enrollment
            Enrollment enrollment = new Enrollment();
            enrollment.setStudent(student);
            enrollment.setCourse(course);
            enrollmentRepository.save(enrollment);

            // 4. Create Exam
            Exam exam = new Exam();
            exam.setTitle("Midterm Examination 2024");
            exam.setFaculty(faculty);
            exam.setCourse(course);
            exam.setTimeLimit(60); // 60 minutes
            exam.setTotalMarks(20);
            exam.setStatus("Live"); // Live so student can see it
            exam = examRepository.save(exam);

            // 5. Create Questions and Options
            createQuestion(exam, "What is the capital of France?", 10, List.of(
                "Berlin", "Madrid", "Paris", "Rome"
            ), 2); // Paris is correct (index 2)

            createQuestion(exam, "Which language is used for Spring Boot?", 10, List.of(
                "Python", "Java", "C++", "JavaScript"
            ), 1); // Java is correct (index 1)

            System.out.println("Mock data initialization complete!");
        } else {
            System.out.println("Exam data exists. Skipping mock initialization.");
        }
    }

    private void createQuestion(Exam exam, String text, int marks, List<String> options, int correctIdx) {
        Question q = new Question();
        q.setExam(exam);
        q.setText(text);
        q.setMarks(marks);
        q = questionRepository.save(q);

        for (int i = 0; i < options.size(); i++) {
            Option o = new Option();
            o.setQuestion(q);
            o.setText(options.get(i));
            o.setIsCorrect(i == correctIdx);
            optionRepository.save(o);
        }
    }
}
