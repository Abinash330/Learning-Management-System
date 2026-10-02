package com.example.lms.admin.dto;

import com.example.lms.contact.model.Contact;
import com.example.lms.notice.model.Notice;
import com.example.lms.user.model.User;

import java.util.List;

public class AdminDashboardDTO {
    private List<User> usersMaster;
    private long activeUsersCount;
    private long facultyCount;
    private long studentCount;
    private long pendingCount;
    private long totalUsers;
    private long totalCourses;
    private long totalEnrollments;
    private long adminCount;
    private int activeUsersPct;
    private int pendingUsersPct;
    private int enrolledPct;
    private int coursesPct;
    private List<User> recentUsers;
    private List<Notice> recentNotices;
    private List<Contact> recentContacts;

    public AdminDashboardDTO() {}

    public List<User> getUsersMaster() { return usersMaster; }
    public void setUsersMaster(List<User> usersMaster) { this.usersMaster = usersMaster; }
    public long getActiveUsersCount() { return activeUsersCount; }
    public void setActiveUsersCount(long activeUsersCount) { this.activeUsersCount = activeUsersCount; }
    public long getFacultyCount() { return facultyCount; }
    public void setFacultyCount(long facultyCount) { this.facultyCount = facultyCount; }
    public long getStudentCount() { return studentCount; }
    public void setStudentCount(long studentCount) { this.studentCount = studentCount; }
    public long getPendingCount() { return pendingCount; }
    public void setPendingCount(long pendingCount) { this.pendingCount = pendingCount; }
    public long getTotalUsers() { return totalUsers; }
    public void setTotalUsers(long totalUsers) { this.totalUsers = totalUsers; }
    public long getTotalCourses() { return totalCourses; }
    public void setTotalCourses(long totalCourses) { this.totalCourses = totalCourses; }
    public long getTotalEnrollments() { return totalEnrollments; }
    public void setTotalEnrollments(long totalEnrollments) { this.totalEnrollments = totalEnrollments; }
    public long getAdminCount() { return adminCount; }
    public void setAdminCount(long adminCount) { this.adminCount = adminCount; }
    public int getActiveUsersPct() { return activeUsersPct; }
    public void setActiveUsersPct(int activeUsersPct) { this.activeUsersPct = activeUsersPct; }
    public int getPendingUsersPct() { return pendingUsersPct; }
    public void setPendingUsersPct(int pendingUsersPct) { this.pendingUsersPct = pendingUsersPct; }
    public int getEnrolledPct() { return enrolledPct; }
    public void setEnrolledPct(int enrolledPct) { this.enrolledPct = enrolledPct; }
    public int getCoursesPct() { return coursesPct; }
    public void setCoursesPct(int coursesPct) { this.coursesPct = coursesPct; }
    public List<User> getRecentUsers() { return recentUsers; }
    public void setRecentUsers(List<User> recentUsers) { this.recentUsers = recentUsers; }
    public List<Notice> getRecentNotices() { return recentNotices; }
    public void setRecentNotices(List<Notice> recentNotices) { this.recentNotices = recentNotices; }
    public List<Contact> getRecentContacts() { return recentContacts; }
    public void setRecentContacts(List<Contact> recentContacts) { this.recentContacts = recentContacts; }
}
