package com.example.lms.exam.dto;

import java.util.Map;

public class ExamSubmissionDTO {
    private Integer examId;
    private Map<Integer, Integer> answers; // questionId -> selectedOptionId

    public ExamSubmissionDTO() {}

    public ExamSubmissionDTO(Integer examId, Map<Integer, Integer> answers) {
        this.examId = examId;
        this.answers = answers;
    }

    public Integer getExamId() { return examId; }
    public void setExamId(Integer examId) { this.examId = examId; }
    public Map<Integer, Integer> getAnswers() { return answers; }
    public void setAnswers(Map<Integer, Integer> answers) { this.answers = answers; }
}
