package com.example.lms.exam.service;

import com.example.lms.course.model.Course;
import com.example.lms.exam.model.*;
import com.example.lms.user.model.User;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface ExamService {
    List<Exam> getAllExams();
    List<ExamResult> getAllResults();
    List<Exam> getExamsByFaculty(User faculty);
    List<Exam> getLiveExamsByCourses(List<Course> courses);
    List<Exam> getExamsByCourse(Course course);
    Optional<Exam> getExamById(Integer id);
    Exam createExam(String title, Integer courseId, Integer totalMarks, Integer timeLimit, User faculty);
    void deleteExam(Integer examId);
    void toggleExamStatus(Integer examId);

    // Questions & Options
    List<Question> getQuestionsByExam(Exam exam);
    List<Option> getOptionsByQuestion(Question question);
    Question saveQuestionWithOptions(Integer examId, Integer questionId, String text, Integer marks, List<String> optionTexts, Integer correctOptionIndex);

    // Student Exam Flow
    Optional<ExamResult> getResultByStudentAndExam(User student, Exam exam);
    ExamResult submitExam(Integer examId, Map<String, String> formParams, User student);
    List<StudentAnswer> getStudentAnswersByResult(ExamResult result);
}
