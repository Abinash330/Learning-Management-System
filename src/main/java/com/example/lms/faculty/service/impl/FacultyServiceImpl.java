package com.example.lms.faculty.service.impl;

import com.example.lms.assignment.model.Assignment;
import com.example.lms.assignment.service.AssignmentService;
import com.example.lms.course.model.Course;
import com.example.lms.course.service.CourseService;
import com.example.lms.enrollment.service.EnrollmentService;
import com.example.lms.faculty.dto.FacultyDashboardDTO;
import com.example.lms.faculty.service.FacultyService;
import com.example.lms.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FacultyServiceImpl implements FacultyService {

    private final CourseService courseService;
    private final EnrollmentService enrollmentService;
    private final AssignmentService assignmentService;

    @Autowired
    public FacultyServiceImpl(CourseService courseService,
                              EnrollmentService enrollmentService,
                              AssignmentService assignmentService) {
        this.courseService = courseService;
        this.enrollmentService = enrollmentService;
        this.assignmentService = assignmentService;
    }

    @Override
    @Transactional(readOnly = true)
    public FacultyDashboardDTO getFacultyDashboard(User faculty) {
        FacultyDashboardDTO dto = new FacultyDashboardDTO();
        dto.setFacultyName(faculty.getName());

        List<Course> courses = courseService.getCoursesByInstructor(faculty);
        dto.setCourses(courses);
        dto.setCourseCount(courses.size());

        long totalStudents = 0;
        long pendingGrade = 0;
        long assignmentCount = 0;

        for (Course c : courses) {
            totalStudents += enrollmentService.countByCourse(c);
            List<Assignment> assigns = assignmentService.getAssignmentsByCourse(c);
            assignmentCount += assigns.size();
            for (Assignment a : assigns) {
                pendingGrade += assignmentService.countPendingGradesByAssignment(a);
            }
        }

        dto.setTotalStudents(totalStudents);
        dto.setPendingGrade(pendingGrade);
        dto.setAssignmentCount(assignmentCount);

        return dto;
    }
}
