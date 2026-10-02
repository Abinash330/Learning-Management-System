package com.example.lms.student.dto;

import com.example.lms.enrollment.model.Enrollment;
import com.example.lms.notice.model.Notice;
import java.util.List;

public class StudentDashboardDTO {
    private String studentName;
    private long enrolledCount;
    private long completedCount;
    private List<Enrollment> enrolledCourses;
    private long totalAssignments;
    private long activeExams;
    private List<Notice> notices;

    public StudentDashboardDTO() {}

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public long getEnrolledCount() { return enrolledCount; }
    public void setEnrolledCount(long enrolledCount) { this.enrolledCount = enrolledCount; }
    public long getCompletedCount() { return completedCount; }
    public void setCompletedCount(long completedCount) { this.completedCount = completedCount; }
    public List<Enrollment> getEnrolledCourses() { return enrolledCourses; }
    public void setEnrolledCourses(List<Enrollment> enrolledCourses) { this.enrolledCourses = enrolledCourses; }
    public long getTotalAssignments() { return totalAssignments; }
    public void setTotalAssignments(long totalAssignments) { this.totalAssignments = totalAssignments; }
    public long getActiveExams() { return activeExams; }
    public void setActiveExams(long activeExams) { this.activeExams = activeExams; }
    public List<Notice> getNotices() { return notices; }
    public void setNotices(List<Notice> notices) { this.notices = notices; }
}
