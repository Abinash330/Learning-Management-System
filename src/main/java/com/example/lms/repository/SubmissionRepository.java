package com.example.lms.repository;

import com.example.lms.model.AssignmentSubmission;
import com.example.lms.model.Assignment;
import com.example.lms.model.User;
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
