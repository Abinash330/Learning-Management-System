package com.example.lms.repository;

import com.example.lms.model.Course;
import com.example.lms.model.Enrollment;
import com.example.lms.model.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class EnrollmentRepositoryTest {

    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CourseRepository courseRepository;

    private User student1;
    private Course course1;

    @BeforeEach
    void setUp() {
        student1 = new User();
        student1.setEmail("student@test.com");
        student1.setRole("Student");
        userRepository.save(student1);

        User instructor = new User();
        instructor.setEmail("instructor@test.com");
        instructor.setRole("Faculty");
        userRepository.save(instructor);

        course1 = new Course();
        course1.setTitle("Test Course");
        course1.setInstructor(instructor);
        courseRepository.save(course1);

        Enrollment enrollment = new Enrollment();
        enrollment.setStudent(student1);
        enrollment.setCourse(course1);
        enrollment.setProgress(50);
        enrollmentRepository.save(enrollment);
    }

    @AfterEach
    void tearDown() {
        enrollmentRepository.deleteAll();
        courseRepository.deleteAll();
        userRepository.deleteAll();
    }

    @Test
    void shouldFindByStudent() {
        List<Enrollment> enrollments = enrollmentRepository.findByStudent(student1);
        assertThat(enrollments).hasSize(1);
    }

    @Test
    void shouldCountByStudent() {
        Long count = enrollmentRepository.countByStudent(student1);
        assertThat(count).isEqualTo(1L);
    }

    @Test
    void shouldCountByStudentAndProgress() {
        Long countMatched = enrollmentRepository.countByStudentAndProgress(student1, 50);
        assertThat(countMatched).isEqualTo(1L);

        Long countUnmatched = enrollmentRepository.countByStudentAndProgress(student1, 100);
        assertThat(countUnmatched).isEqualTo(0L);
    }

    @Test
    void shouldCountByCourse() {
        Long count = enrollmentRepository.countByCourse(course1);
        assertThat(count).isEqualTo(1L);
    }

    @Test
    void shouldFindByStudentAndCourse() {
        Optional<Enrollment> enrollmentOpt = enrollmentRepository.findByStudentAndCourse(student1, course1);
        assertThat(enrollmentOpt).isPresent();
    }
}
