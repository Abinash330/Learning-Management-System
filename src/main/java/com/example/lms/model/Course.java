package com.example.lms.model;

import jakarta.persistence.*;

@Entity
@Table(name = "courses")
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String title;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "instructor_id")
    private User instructor;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id")
    private Department department;

    @Transient
    private Integer enrolledCount;

    public Course() {}

    public Course(Integer id, String title, String description, User instructor, Integer enrolledCount) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.instructor = instructor;
        this.enrolledCount = enrolledCount;
    }

    public Course(Integer id, String title, String description, User instructor, Department department, Integer enrolledCount) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.instructor = instructor;
        this.department = department;
        this.enrolledCount = enrolledCount;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public User getInstructor() { return instructor; }
    public void setInstructor(User instructor) { this.instructor = instructor; }
    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
    public Integer getEnrolledCount() { return enrolledCount; }
    public void setEnrolledCount(Integer enrolledCount) { this.enrolledCount = enrolledCount; }
}
