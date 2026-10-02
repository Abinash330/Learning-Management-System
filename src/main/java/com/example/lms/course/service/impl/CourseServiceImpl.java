package com.example.lms.course.service.impl;

import com.example.lms.common.exception.ResourceNotFoundException;
import com.example.lms.course.model.Course;
import com.example.lms.course.repository.CourseRepository;
import com.example.lms.course.service.CourseService;
import com.example.lms.department.repository.DepartmentRepository;
import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CourseServiceImpl implements CourseService {

    private final CourseRepository courseRepository;
    private final UserRepository userRepository;
    private final DepartmentRepository departmentRepository;

    @Autowired
    public CourseServiceImpl(CourseRepository courseRepository,
                             UserRepository userRepository,
                             DepartmentRepository departmentRepository) {
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
        this.departmentRepository = departmentRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Course> getCourseById(Integer id) {
        return courseRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Course> getCoursesByInstructor(User instructor) {
        return courseRepository.findByInstructor(instructor);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Course> searchCourses(String query) {
        if (query == null || query.isBlank()) {
            return courseRepository.findAll();
        }
        return courseRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(query, query);
    }

    @Override
    public Course saveCourse(Course course) {
        return courseRepository.save(course);
    }

    @Override
    public Course createCourse(String title, String description, Integer instructorId, Integer departmentId) {
        User instructor = userRepository.findById(instructorId)
                .orElseThrow(() -> new ResourceNotFoundException("Instructor not found with id: " + instructorId));
        
        Course course = new Course();
        course.setTitle(title);
        course.setDescription(description);
        course.setInstructor(instructor);
        if (departmentId != null && departmentId > 0) {
            departmentRepository.findById(departmentId).ifPresent(course::setDepartment);
        }
        return courseRepository.save(course);
    }

    @Override
    public void deleteCourseById(Integer id) {
        courseRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public long countCourses() {
        return courseRepository.count();
    }
}
