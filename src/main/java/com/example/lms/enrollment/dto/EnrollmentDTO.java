package com.example.lms.enrollment.dto;

public class EnrollmentDTO {
    private Integer id;
    private Integer studentId;
    private String studentName;
    private Integer courseId;
    private String courseTitle;
    private Integer progress;

    public EnrollmentDTO() {}

    public EnrollmentDTO(Integer id, Integer studentId, String studentName, Integer courseId, String courseTitle, Integer progress) {
        this.id = id;
        this.studentId = studentId;
        this.studentName = studentName;
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.progress = progress;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    public Integer getProgress() { return progress; }
    public void setProgress(Integer progress) { this.progress = progress; }
}
