package com.example.lms.assignment.dto;

import java.time.LocalDateTime;

public class AssignmentDTO {
    private Integer id;
    private Integer courseId;
    private String courseTitle;
    private String title;
    private String description;
    private String dueDate;
    private Integer createdById;
    private String createdByName;
    private LocalDateTime createdAt;
    private Integer submissionCount;
    private Integer gradedCount;
    private String subStatus;
    private Integer marks;

    public AssignmentDTO() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }
    public Integer getCreatedById() { return createdById; }
    public void setCreatedById(Integer createdById) { this.createdById = createdById; }
    public String getCreatedByName() { return createdByName; }
    public void setCreatedByName(String createdByName) { this.createdByName = createdByName; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public Integer getSubmissionCount() { return submissionCount; }
    public void setSubmissionCount(Integer submissionCount) { this.submissionCount = submissionCount; }
    public Integer getGradedCount() { return gradedCount; }
    public void setGradedCount(Integer gradedCount) { this.gradedCount = gradedCount; }
    public String getSubStatus() { return subStatus; }
    public void setSubStatus(String subStatus) { this.subStatus = subStatus; }
    public Integer getMarks() { return marks; }
    public void setMarks(Integer marks) { this.marks = marks; }
}
