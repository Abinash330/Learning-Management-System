package com.example.lms.model;

import jakarta.persistence.*;
@Entity
@Table(name = "contact")
public class Contact {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String email;
    private String mobile;
    private String subject;
    
    @Column(columnDefinition = "TEXT")
    private String message;

    public Contact() {}
    public Contact(Integer id, String name, String email, String mobile, String subject, String message) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.mobile = mobile;
        this.subject = subject;
        this.message = message;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
}
