package com.example.lms.faculty.dto;

import com.example.lms.course.model.Course;
import java.util.List;

public class FacultyDashboardDTO {
    private String facultyName;
    private List<Course> courses;
    private int courseCount;
    private long totalStudents;
    private long pendingGrade;
    private long assignmentCount;

    public FacultyDashboardDTO() {}

    public String getFacultyName() { return facultyName; }
    public void setFacultyName(String facultyName) { this.facultyName = facultyName; }
    public List<Course> getCourses() { return courses; }
    public void setCourses(List<Course> courses) { this.courses = courses; }
    public int getCourseCount() { return courseCount; }
    public void setCourseCount(int courseCount) { this.courseCount = courseCount; }
    public long getTotalStudents() { return totalStudents; }
    public void setTotalStudents(long totalStudents) { this.totalStudents = totalStudents; }
    public long getPendingGrade() { return pendingGrade; }
    public void setPendingGrade(long pendingGrade) { this.pendingGrade = pendingGrade; }
    public long getAssignmentCount() { return assignmentCount; }
    public void setAssignmentCount(long assignmentCount) { this.assignmentCount = assignmentCount; }
}
