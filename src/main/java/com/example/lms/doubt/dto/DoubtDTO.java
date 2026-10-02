package com.example.lms.doubt.dto;

import java.time.LocalDateTime;

public class DoubtDTO {
    private Long id;
    private String questionText;
    private String reply;
    private String status;
    private LocalDateTime askedAt;
    private LocalDateTime repliedAt;
    private Long videoId;
    private String videoTitle;
    private Integer studentId;
    private String studentName;
    private Integer repliedById;
    private String repliedByName;

    public DoubtDTO() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getQuestionText() { return questionText; }
    public void setQuestionText(String questionText) { this.questionText = questionText; }
    public String getReply() { return reply; }
    public void setReply(String reply) { this.reply = reply; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getAskedAt() { return askedAt; }
    public void setAskedAt(LocalDateTime askedAt) { this.askedAt = askedAt; }
    public LocalDateTime getRepliedAt() { return repliedAt; }
    public void setRepliedAt(LocalDateTime repliedAt) { this.repliedAt = repliedAt; }
    public Long getVideoId() { return videoId; }
    public void setVideoId(Long videoId) { this.videoId = videoId; }
    public String getVideoTitle() { return videoTitle; }
    public void setVideoTitle(String videoTitle) { this.videoTitle = videoTitle; }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public Integer getRepliedById() { return repliedById; }
    public void setRepliedById(Integer repliedById) { this.repliedById = repliedById; }
    public String getRepliedByName() { return repliedByName; }
    public void setRepliedByName(String repliedByName) { this.repliedByName = repliedByName; }
}
