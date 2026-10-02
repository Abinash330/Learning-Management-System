package com.example.lms.assignment.service;

import com.example.lms.assignment.model.Assignment;
import com.example.lms.assignment.model.AssignmentSubmission;
import com.example.lms.course.model.Course;
import com.example.lms.user.model.User;

import java.util.List;
import java.util.Optional;

public interface AssignmentService {
    List<Assignment> getAssignmentsByCourse(Course course);
    List<Assignment> getAssignmentsByCourseOrderByCreatedAtDesc(Course course);
    Optional<Assignment> getAssignmentById(Integer id);
    Assignment createAssignment(Integer courseId, String title, String description, String dueDate, User createdBy);
    Assignment saveAssignment(Assignment assignment);
    
    // Submissions
    AssignmentSubmission submitAssignment(Integer assignmentId, String answer, User student);
    AssignmentSubmission gradeSubmission(Integer submissionId, Integer marks, String feedback);
    Optional<AssignmentSubmission> getSubmissionById(Integer submissionId);
    Optional<AssignmentSubmission> getSubmissionByAssignmentAndStudent(Assignment assignment, User student);
    List<AssignmentSubmission> getSubmissionsByAssignment(Assignment assignment);
    long countSubmissionsByAssignment(Assignment assignment);
    long countPendingGradesByAssignment(Assignment assignment);
}
