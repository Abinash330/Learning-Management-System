package com.example.lms.course.service;

import com.example.lms.course.model.Course;
import com.example.lms.user.model.User;

import java.util.List;
import java.util.Optional;

public interface CourseService {
    List<Course> getAllCourses();
    Optional<Course> getCourseById(Integer id);
    List<Course> getCoursesByInstructor(User instructor);
    List<Course> searchCourses(String query);
    Course saveCourse(Course course);
    Course createCourse(String title, String description, Integer instructorId, Integer departmentId);
    void deleteCourseById(Integer id);
    long countCourses();
}
