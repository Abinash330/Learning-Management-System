package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "assignments")
public class Assignment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "course_id")
    private Course course;
    
    private String title;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "due_date")
    private String dueDate;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "created_by")
    private User createdBy;
    
    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Transient
    private Integer submissionCount;
    @Transient
    private Integer gradedCount;
    @Transient
    private Integer submissionId;
    @Transient
    private String subStatus;
    @Transient
    private Integer marks;

    public Assignment() {}
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }
    public User getCreatedBy() { return createdBy; }
    public void setCreatedBy(User createdBy) { this.createdBy = createdBy; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public Integer getSubmissionCount() { return submissionCount; }
    public void setSubmissionCount(Integer submissionCount) { this.submissionCount = submissionCount; }
    public Integer getGradedCount() { return gradedCount; }
    public void setGradedCount(Integer gradedCount) { this.gradedCount = gradedCount; }
    public Integer getSubmissionId() { return submissionId; }
    public void setSubmissionId(Integer submissionId) { this.submissionId = submissionId; }
    public String getSubStatus() { return subStatus; }
    public void setSubStatus(String subStatus) { this.subStatus = subStatus; }
    public Integer getMarks() { return marks; }
    public void setMarks(Integer marks) { this.marks = marks; }
}
