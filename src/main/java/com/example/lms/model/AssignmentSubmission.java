package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "assignment_submissions")
public class AssignmentSubmission {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "assignment_id")
    private Assignment assignment;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "student_id")
    private User student;
    
    @Column(columnDefinition = "TEXT")
    private String answer;
    
    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;
    
    @Column(columnDefinition = "varchar(255) default 'submitted'")
    private String status;
    
    private Integer marks;
    
    @Column(columnDefinition = "TEXT")
    private String feedback;

    public AssignmentSubmission() {}
    public AssignmentSubmission(Integer id, Assignment assignment, User student, String answer, LocalDateTime submittedAt, String status, Integer marks, String feedback) {
        this.id = id;
        this.assignment = assignment;
        this.student = student;
        this.answer = answer;
        this.submittedAt = submittedAt;
        this.status = status;
        this.marks = marks;
        this.feedback = feedback;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Assignment getAssignment() { return assignment; }
    public void setAssignment(Assignment assignment) { this.assignment = assignment; }
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }
    public LocalDateTime getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(LocalDateTime submittedAt) { this.submittedAt = submittedAt; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Integer getMarks() { return marks; }
    public void setMarks(Integer marks) { this.marks = marks; }
    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }
}
