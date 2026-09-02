package com.example.lms.model;

import java.time.LocalDate;
import jakarta.persistence.*;
@Entity
@Table(name = "notice_master")
public class Notice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "notice_date")
    private LocalDate noticeDate;

    @Column(name = "target_audience", length = 50)
    private String targetAudience; // "ALL", "STUDENT", "FACULTY"

    @Column(name = "file_path")
    private String filePath;

    @Column(name = "file_name")
    private String fileName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_user_id")
    @com.fasterxml.jackson.annotation.JsonIgnore
    private User createdBy;

    public Notice() {}
    public Notice(Long id, String title, String description, LocalDate noticeDate, String targetAudience, String filePath, String fileName, User createdBy) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.noticeDate = noticeDate;
        this.targetAudience = targetAudience;
        this.filePath = filePath;
        this.fileName = fileName;
        this.createdBy = createdBy;
    }
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDate getNoticeDate() { return noticeDate; }
    public void setNoticeDate(LocalDate noticeDate) { this.noticeDate = noticeDate; }
    public String getTargetAudience() { return targetAudience; }
    public void setTargetAudience(String targetAudience) { this.targetAudience = targetAudience; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }
    public User getCreatedBy() { return createdBy; }
    public void setCreatedBy(User createdBy) { this.createdBy = createdBy; }
}
