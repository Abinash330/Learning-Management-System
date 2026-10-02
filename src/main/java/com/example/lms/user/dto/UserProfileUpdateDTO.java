package com.example.lms.user.dto;

public class UserProfileUpdateDTO {
    private String name;
    private String mobile;

    public UserProfileUpdateDTO() {}

    public UserProfileUpdateDTO(String name, String mobile) {
        this.name = name;
        this.mobile = mobile;
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
}
