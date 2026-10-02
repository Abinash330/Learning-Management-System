package com.example.lms.course.dto;

public class CourseDTO {
    private Integer id;
    private String title;
    private String description;
    private Integer instructorId;
    private String instructorName;
    private Integer departmentId;
    private String departmentName;
    private Integer enrolledCount;

    public CourseDTO() {}

    public CourseDTO(Integer id, String title, String description, Integer instructorId, String instructorName, Integer departmentId, String departmentName, Integer enrolledCount) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.instructorId = instructorId;
        this.instructorName = instructorName;
        this.departmentId = departmentId;
        this.departmentName = departmentName;
        this.enrolledCount = enrolledCount;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Integer getInstructorId() { return instructorId; }
    public void setInstructorId(Integer instructorId) { this.instructorId = instructorId; }
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    public Integer getDepartmentId() { return departmentId; }
    public void setDepartmentId(Integer departmentId) { this.departmentId = departmentId; }
    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
    public Integer getEnrolledCount() { return enrolledCount; }
    public void setEnrolledCount(Integer enrolledCount) { this.enrolledCount = enrolledCount; }
}
