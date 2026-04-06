package com.example.lms.model;

import jakarta.persistence.*;
@Entity
@Table(name = "user_master")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    
    @Column(unique = true)
    private String email;
    
    private String mobile;
    private String password;
    private String role; // "Student", "Faculty", "Admin"
    
    @Column(columnDefinition = "int default 0")
    private Integer status; // 1 for active, 0 for pending/inactive
    
    @Column(name = "is_online", columnDefinition = "int default 0")
    private Integer isOnline; // 1 for online, 0 for offline

    public User() {}
    public User(Integer id, String name, String email, String mobile, String password, String role, Integer status, Integer isOnline) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.mobile = mobile;
        this.password = password;
        this.role = role;
        this.status = status;
        this.isOnline = isOnline;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getIsOnline() { return isOnline; }
    public void setIsOnline(Integer isOnline) { this.isOnline = isOnline; }
}
