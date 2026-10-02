package com.example.lms.student.service.impl;

import com.example.lms.assignment.repository.AssignmentRepository;
import com.example.lms.course.model.Course;
import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.enrollment.repository.EnrollmentRepository;
import com.example.lms.exam.repository.ExamRepository;
import com.example.lms.notice.repository.NoticeRepository;
import com.example.lms.student.dto.StudentDashboardDTO;
import com.example.lms.student.service.StudentService;
import com.example.lms.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class StudentServiceImpl implements StudentService {

    private final EnrollmentRepository enrollmentRepository;
    private final AssignmentRepository assignmentRepository;
    private final ExamRepository examRepository;
    private final NoticeRepository noticeRepository;

    @Autowired
    public StudentServiceImpl(EnrollmentRepository enrollmentRepository,
                              AssignmentRepository assignmentRepository,
                              ExamRepository examRepository,
                              NoticeRepository noticeRepository) {
        this.enrollmentRepository = enrollmentRepository;
        this.assignmentRepository = assignmentRepository;
        this.examRepository = examRepository;
        this.noticeRepository = noticeRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public StudentDashboardDTO getStudentDashboard(User student) {
        StudentDashboardDTO dto = new StudentDashboardDTO();
        dto.setStudentName(student.getName());

        long enrolledCount = enrollmentRepository.countByStudent(student);
        dto.setEnrolledCount(enrolledCount);

        long completedCount = enrollmentRepository.countByStudentAndProgress(student, 100);
        dto.setCompletedCount(completedCount);

        List<Enrollment> enrolledCourses = enrollmentRepository.findByStudent(student);
        dto.setEnrolledCourses(enrolledCourses);

        long totalAssignments = 0;
        List<Course> courses = enrolledCourses.stream().map(Enrollment::getCourse).collect(Collectors.toList());
        for (Course c : courses) {
            totalAssignments += assignmentRepository.findByCourse(c).size();
        }
        dto.setTotalAssignments(totalAssignments);

        long activeExams = 0;
        if (!courses.isEmpty()) {
            activeExams = examRepository.findByCourseInAndStatus(courses, "Live").size();
        }
        dto.setActiveExams(activeExams);

        dto.setNotices(noticeRepository.findTop3ByOrderByIdDesc());

        return dto;
    }
}
