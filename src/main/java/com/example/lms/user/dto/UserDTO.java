package com.example.lms.user.dto;

public class UserDTO {
    private Integer id;
    private String name;
    private String email;
    private String mobile;
    private String role;
    private Integer status;
    private Integer isOnline;
    private String departmentName;

    public UserDTO() {}

    public UserDTO(Integer id, String name, String email, String mobile, String role, Integer status, Integer isOnline, String departmentName) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.mobile = mobile;
        this.role = role;
        this.status = status;
        this.isOnline = isOnline;
        this.departmentName = departmentName;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getIsOnline() { return isOnline; }
    public void setIsOnline(Integer isOnline) { this.isOnline = isOnline; }
    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
}
