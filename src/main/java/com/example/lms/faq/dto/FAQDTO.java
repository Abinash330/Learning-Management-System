package com.example.lms.faq.dto;

public class FAQDTO {
    private Integer id;
    private String question;
    private String answer;
    private String role;
    private String category;

    public FAQDTO() {}

    public FAQDTO(Integer id, String question, String answer, String role, String category) {
        this.id = id;
        this.question = question;
        this.answer = answer;
        this.role = role;
        this.category = category;
    }

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
