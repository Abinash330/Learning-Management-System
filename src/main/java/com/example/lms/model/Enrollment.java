package com.example.lms.model;

import jakarta.persistence.*;
@Entity
@Table(name = "enrollments")
public class Enrollment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "student_id")
    private User student;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "course_id")
    private Course course;
    
    @Column(columnDefinition = "int default 0")
    private Integer progress;

    public Enrollment() {}
    public Enrollment(Integer id, User student, Course course, Integer progress) {
        this.id = id;
        this.student = student;
        this.course = course;
        this.progress = progress;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    public Integer getProgress() { return progress; }
    public void setProgress(Integer progress) { this.progress = progress; }
}
