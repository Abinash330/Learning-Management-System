package com.example.lms.repository;

import com.example.lms.model.Assignment;
import com.example.lms.model.AssignmentSubmission;
import com.example.lms.model.Course;
import com.example.lms.model.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class SubmissionRepositoryTest {

    @Autowired
    private SubmissionRepository submissionRepository;
    @Autowired
    private AssignmentRepository assignmentRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserRepository userRepository;

    private Assignment assignment1;
    private User student1;

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

        Course course = new Course();
        course.setTitle("Course");
        course.setInstructor(instructor);
        courseRepository.save(course);

        assignment1 = new Assignment();
        assignment1.setCourse(course);
        assignment1.setTitle("Assignment");
        assignment1.setCreatedBy(instructor);
        assignmentRepository.save(assignment1);

        AssignmentSubmission sub1 = new AssignmentSubmission();
        sub1.setAssignment(assignment1);
        sub1.setStudent(student1);
        sub1.setStatus("submitted");
        sub1.setSubmittedAt(LocalDateTime.now());
        submissionRepository.save(sub1);
    }

    @AfterEach
    void tearDown() {
        submissionRepository.deleteAll();
        assignmentRepository.deleteAll();
        courseRepository.deleteAll();
        userRepository.deleteAll();
    }

    @Test
    void shouldFindByAssignmentAndStudent() {
        Optional<AssignmentSubmission> sub = submissionRepository.findByAssignmentAndStudent(assignment1, student1);
        assertThat(sub).isPresent();
    }

    @Test
    void shouldFindByAssignment() {
        List<AssignmentSubmission> subs = submissionRepository.findByAssignment(assignment1);
        assertThat(subs).hasSize(1);
    }

    @Test
    void shouldCountByAssignment() {
        Long count = submissionRepository.countByAssignment(assignment1);
        assertThat(count).isEqualTo(1L);
    }

    @Test
    void shouldCountByAssignmentAndStatus() {
        Long count = submissionRepository.countByAssignmentAndStatus(assignment1, "submitted");
        assertThat(count).isEqualTo(1L);
        
        Long count2 = submissionRepository.countByAssignmentAndStatus(assignment1, "graded");
        assertThat(count2).isEqualTo(0L);
    }
}
