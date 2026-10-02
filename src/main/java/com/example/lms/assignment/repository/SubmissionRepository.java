package com.example.lms.assignment.repository;

import com.example.lms.assignment.model.Assignment;
import com.example.lms.assignment.model.AssignmentSubmission;
import com.example.lms.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SubmissionRepository extends JpaRepository<AssignmentSubmission, Integer> {
    Optional<AssignmentSubmission> findByAssignmentAndStudent(Assignment assignment, User student);
    List<AssignmentSubmission> findByAssignment(Assignment assignment);
    Long countByAssignment(Assignment assignment);
    Long countByAssignmentAndStatus(Assignment assignment, String status);
}
