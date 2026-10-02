package com.example.lms.assignment.service.impl;

import com.example.lms.assignment.model.Assignment;
import com.example.lms.assignment.model.AssignmentSubmission;
import com.example.lms.assignment.repository.AssignmentRepository;
import com.example.lms.assignment.repository.SubmissionRepository;
import com.example.lms.assignment.service.AssignmentService;
import com.example.lms.common.exception.ResourceNotFoundException;
import com.example.lms.course.model.Course;
import com.example.lms.course.repository.CourseRepository;
import com.example.lms.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class AssignmentServiceImpl implements AssignmentService {

    private final AssignmentRepository assignmentRepository;
    private final SubmissionRepository submissionRepository;
    private final CourseRepository courseRepository;

    @Autowired
    public AssignmentServiceImpl(AssignmentRepository assignmentRepository,
                                 SubmissionRepository submissionRepository,
                                 CourseRepository courseRepository) {
        this.assignmentRepository = assignmentRepository;
        this.submissionRepository = submissionRepository;
        this.courseRepository = courseRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Assignment> getAssignmentsByCourse(Course course) {
        return assignmentRepository.findByCourse(course);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Assignment> getAssignmentsByCourseOrderByCreatedAtDesc(Course course) {
        return assignmentRepository.findByCourseOrderByCreatedAtDesc(course);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Assignment> getAssignmentById(Integer id) {
        return assignmentRepository.findById(id);
    }

    @Override
    public Assignment createAssignment(Integer courseId, String title, String description, String dueDate, User createdBy) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course not found with id: " + courseId));
        
        Assignment assignment = new Assignment();
        assignment.setCourse(course);
        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setDueDate(dueDate);
        assignment.setCreatedBy(createdBy);
        return assignmentRepository.save(assignment);
    }

    @Override
    public Assignment saveAssignment(Assignment assignment) {
        return assignmentRepository.save(assignment);
    }

    @Override
    public AssignmentSubmission submitAssignment(Integer assignmentId, String answer, User student) {
        Assignment assignment = assignmentRepository.findById(assignmentId)
                .orElseThrow(() -> new ResourceNotFoundException("Assignment not found with id: " + assignmentId));

        Optional<AssignmentSubmission> subOpt = submissionRepository.findByAssignmentAndStudent(assignment, student);
        AssignmentSubmission submission = subOpt.orElseGet(AssignmentSubmission::new);
        
        submission.setAssignment(assignment);
        submission.setStudent(student);
        submission.setAnswer(answer);
        submission.setStatus("submitted");
        submission.setSubmittedAt(LocalDateTime.now());
        return submissionRepository.save(submission);
    }

    @Override
    public AssignmentSubmission gradeSubmission(Integer submissionId, Integer marks, String feedback) {
        AssignmentSubmission submission = submissionRepository.findById(submissionId)
                .orElseThrow(() -> new ResourceNotFoundException("Submission not found with id: " + submissionId));
        submission.setMarks(marks);
        submission.setFeedback(feedback);
        submission.setStatus("graded");
        return submissionRepository.save(submission);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<AssignmentSubmission> getSubmissionById(Integer submissionId) {
        return submissionRepository.findById(submissionId);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<AssignmentSubmission> getSubmissionByAssignmentAndStudent(Assignment assignment, User student) {
        return submissionRepository.findByAssignmentAndStudent(assignment, student);
    }

    @Override
    @Transactional(readOnly = true)
    public List<AssignmentSubmission> getSubmissionsByAssignment(Assignment assignment) {
        return submissionRepository.findByAssignment(assignment);
    }

    @Override
    @Transactional(readOnly = true)
    public long countSubmissionsByAssignment(Assignment assignment) {
        return submissionRepository.countByAssignment(assignment);
    }

    @Override
    @Transactional(readOnly = true)
    public long countPendingGradesByAssignment(Assignment assignment) {
        return submissionRepository.countByAssignmentAndStatus(assignment, "submitted");
    }
}
