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

    public Notice() {}
    public Notice(Long id, String title, String description, LocalDate noticeDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.noticeDate = noticeDate;
    }
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDate getNoticeDate() { return noticeDate; }
    public void setNoticeDate(LocalDate noticeDate) { this.noticeDate = noticeDate; }
}
