package com.example.lms.exam.dto;

import java.util.List;

public class QuestionDTO {
    private Integer id;
    private Integer examId;
    private String text;
    private Integer marks;
    private List<String> options;
    private Integer correctOptionIndex;

    public QuestionDTO() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getExamId() { return examId; }
    public void setExamId(Integer examId) { this.examId = examId; }
    public String getText() { return text; }
    public void setText(String text) { this.text = text; }
    public Integer getMarks() { return marks; }
    public void setMarks(Integer marks) { this.marks = marks; }
    public List<String> getOptions() { return options; }
    public void setOptions(List<String> options) { this.options = options; }
    public Integer getCorrectOptionIndex() { return correctOptionIndex; }
    public void setCorrectOptionIndex(Integer correctOptionIndex) { this.correctOptionIndex = correctOptionIndex; }
}
