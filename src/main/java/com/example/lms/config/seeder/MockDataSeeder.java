package com.example.lms.config.seeder;

import com.example.lms.course.model.Course;
import com.example.lms.course.repository.CourseRepository;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.enrollment.repository.EnrollmentRepository;
import com.example.lms.exam.model.Exam;
import com.example.lms.exam.model.Option;
import com.example.lms.exam.model.Question;
import com.example.lms.exam.repository.ExamRepository;
import com.example.lms.exam.repository.OptionRepository;
import com.example.lms.exam.repository.QuestionRepository;
import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Order(5)
@ConditionalOnProperty(name = "app.seeder.enabled", havingValue = "true", matchIfMissing = true)
public class MockDataSeeder implements CommandLineRunner {

    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final ExamRepository examRepository;
    private final QuestionRepository questionRepository;
    private final OptionRepository optionRepository;

    @Autowired
    public MockDataSeeder(UserRepository userRepository,
                          CourseRepository courseRepository,
                          EnrollmentRepository enrollmentRepository,
                          ExamRepository examRepository,
                          QuestionRepository questionRepository,
                          OptionRepository optionRepository) {
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.enrollmentRepository = enrollmentRepository;
        this.examRepository = examRepository;
        this.questionRepository = questionRepository;
        this.optionRepository = optionRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        if (examRepository.count() == 0) {
            System.out.println("No exams found in database. Initializing mock data...");

            // 1. Create Users
            User admin = userRepository.findByEmail("admin@example.com").orElseGet(() -> {
                User u = new User();
                u.setName("Admin User");
                u.setEmail("admin@example.com");
                u.setPassword("password");
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
            ), 2);

            createQuestion(exam, "Which language is used for Spring Boot?", 10, List.of(
                "Python", "Java", "C++", "JavaScript"
            ), 1);

            System.out.println("Mock data initialization complete!");
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
