package com.example.lms.repository;

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
public class CourseRepositoryTest {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private UserRepository userRepository;

    private User instructor1;
    private User instructor2;

    @BeforeEach
    void setUp() {
        instructor1 = new User();
        instructor1.setName("Dr. Smith");
        instructor1.setEmail("smith@test.com");
        instructor1.setRole("Faculty");
        userRepository.save(instructor1);

        instructor2 = new User();
        instructor2.setName("Dr. Jones");
        instructor2.setEmail("jones@test.com");
        instructor2.setRole("Faculty");
        userRepository.save(instructor2);

        Course course1 = new Course();
        course1.setTitle("Java Programming");
        course1.setDescription("Learn Java from scratch");
        course1.setInstructor(instructor1);
        courseRepository.save(course1);

        Course course2 = new Course();
        course2.setTitle("Spring Boot Advanced");
        course2.setDescription("Mastering Spring Boot");
        course2.setInstructor(instructor1);
        courseRepository.save(course2);

        Course course3 = new Course();
        course3.setTitle("Database Design");
        course3.setDescription("Learn SQL and MongoDB");
        course3.setInstructor(instructor2);
        courseRepository.save(course3);
    }

    @AfterEach
    void tearDown() {
        courseRepository.deleteAll();
        userRepository.deleteAll();
    }

    @Test
    void shouldFindByInstructor() {
        List<Course> courses = courseRepository.findByInstructor(instructor1);
        assertThat(courses).hasSize(2);
        assertThat(courses).extracting(Course::getTitle).contains("Java Programming", "Spring Boot Advanced");

        courses = courseRepository.findByInstructor(instructor2);
        assertThat(courses).hasSize(1);
    }

    @Test
    void shouldFindByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase() {
        List<Course> courses = courseRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase("java", "java");
        assertThat(courses).hasSize(1);
        assertThat(courses.get(0).getTitle()).isEqualTo("Java Programming");

        courses = courseRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase("SPRING", "SPRING");
        assertThat(courses).hasSize(1);
    }

    @Test
    void shouldFindByTitleContainingOrDescriptionContaining() {
        List<Course> courses = courseRepository.findByTitleContainingOrDescriptionContaining("Database", "Database");
        assertThat(courses).hasSize(1);
        
        courses = courseRepository.findByTitleContainingOrDescriptionContaining("java", "java");
        assertThat(courses).isEmpty(); // Case sensitive match
    }
}
