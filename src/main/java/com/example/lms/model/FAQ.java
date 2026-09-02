package com.example.lms.model;

import jakarta.persistence.*;

@Entity
@Table(name = "faq_master")
public class FAQ {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 500)
    private String question;

    @Column(columnDefinition = "TEXT")
    private String answer;

    private String role; // "Student", "Faculty", "Admin", "All"

    @Column(length = 50)
    private String category; // e.g., "Registration", "Courses", "Technical"

    public FAQ() {}

    public FAQ(String question, String answer, String role, String category) {
        this.question = question;
        this.answer = answer;
        this.role = role;
        this.category = category;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
