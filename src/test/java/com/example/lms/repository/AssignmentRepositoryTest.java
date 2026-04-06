package com.example.lms.repository;

import com.example.lms.model.Assignment;
import com.example.lms.model.Course;
import com.example.lms.model.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class AssignmentRepositoryTest {

    @Autowired
    private AssignmentRepository assignmentRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserRepository userRepository;

    private Course course1;

    @BeforeEach
    void setUp() {
        User instructor = new User();
        instructor.setEmail("instructor@test.com");
        instructor.setRole("Faculty");
        userRepository.save(instructor);

        course1 = new Course();
        course1.setTitle("Test Course");
        course1.setInstructor(instructor);
        courseRepository.save(course1);

        Assignment assignment1 = new Assignment();
        assignment1.setCourse(course1);
        assignment1.setTitle("Assignment 1");
        assignment1.setCreatedBy(instructor);
        assignmentRepository.save(assignment1);
        
        Assignment assignment2 = new Assignment();
        assignment2.setCourse(course1);
        assignment2.setTitle("Assignment 2");
        assignment2.setCreatedBy(instructor);
        assignmentRepository.save(assignment2);
    }

    @AfterEach
    void tearDown() {
        assignmentRepository.deleteAll();
        courseRepository.deleteAll();
        userRepository.deleteAll();
    }

    @Test
    void shouldFindByCourseOrderByCreatedAtDesc() {
        List<Assignment> assignments = assignmentRepository.findByCourseOrderByCreatedAtDesc(course1);
        assertThat(assignments).hasSize(2);
    }

    @Test
    void shouldFindByCourse() {
        List<Assignment> assignments = assignmentRepository.findByCourse(course1);
        assertThat(assignments).hasSize(2);
    }
}
