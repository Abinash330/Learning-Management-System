package com.example.lms.exam.service.impl;

import com.example.lms.common.exception.ResourceNotFoundException;
import com.example.lms.course.model.Course;
import com.example.lms.course.repository.CourseRepository;
import com.example.lms.exam.model.*;
import com.example.lms.exam.repository.*;
import com.example.lms.exam.service.ExamService;
import com.example.lms.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class ExamServiceImpl implements ExamService {

    private final ExamRepository examRepository;
    private final QuestionRepository questionRepository;
    private final OptionRepository optionRepository;
    private final ExamResultRepository examResultRepository;
    private final StudentAnswerRepository studentAnswerRepository;
    private final CourseRepository courseRepository;

    @Autowired
    public ExamServiceImpl(ExamRepository examRepository,
                           QuestionRepository questionRepository,
                           OptionRepository optionRepository,
                           ExamResultRepository examResultRepository,
                           StudentAnswerRepository studentAnswerRepository,
                           CourseRepository courseRepository) {
        this.examRepository = examRepository;
        this.questionRepository = questionRepository;
        this.optionRepository = optionRepository;
        this.examResultRepository = examResultRepository;
        this.studentAnswerRepository = studentAnswerRepository;
        this.courseRepository = courseRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Exam> getAllExams() {
        return examRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ExamResult> getAllResults() {
        return examResultRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Exam> getExamsByFaculty(User faculty) {
        return examRepository.findByFaculty(faculty);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Exam> getLiveExamsByCourses(List<Course> courses) {
        if (courses == null || courses.isEmpty()) {
            return Collections.emptyList();
        }
        return examRepository.findByCourseInAndStatus(courses, "Live");
    }

    @Override
    @Transactional(readOnly = true)
    public List<Exam> getExamsByCourse(Course course) {
        return examRepository.findByCourse(course);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Exam> getExamById(Integer id) {
        return examRepository.findById(id);
    }

    @Override
    public Exam createExam(String title, Integer courseId, Integer totalMarks, Integer timeLimit, User faculty) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course not found with id: " + courseId));
        Exam exam = new Exam();
        exam.setTitle(title);
        exam.setCourse(course);
        exam.setFaculty(faculty);
        exam.setTotalMarks(totalMarks);
        exam.setTimeLimit(timeLimit);
        exam.setStatus("Draft");
        return examRepository.save(exam);
    }

    @Override
    public void deleteExam(Integer examId) {
        examRepository.deleteById(examId);
    }

    @Override
    public void toggleExamStatus(Integer examId) {
        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new ResourceNotFoundException("Exam not found with id: " + examId));
        exam.setStatus("Draft".equalsIgnoreCase(exam.getStatus()) ? "Live" : "Draft");
        examRepository.save(exam);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Question> getQuestionsByExam(Exam exam) {
        return questionRepository.findByExam(exam);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Option> getOptionsByQuestion(Question question) {
        return optionRepository.findByQuestion(question);
    }

    @Override
    public Question saveQuestionWithOptions(Integer examId, Integer questionId, String text, Integer marks, List<String> optionTexts, Integer correctOptionIndex) {
        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new ResourceNotFoundException("Exam not found with id: " + examId));
        
        Question question = (questionId != null) ? questionRepository.findById(questionId).orElse(new Question()) : new Question();
        question.setExam(exam);
        question.setText(text);
        question.setMarks(marks);
        question = questionRepository.save(question);

        if (questionId != null) {
            List<Option> existingOptions = optionRepository.findByQuestion(question);
            optionRepository.deleteAll(existingOptions);
        }

        if (optionTexts != null) {
            for (int i = 0; i < optionTexts.size(); i++) {
                Option opt = new Option();
                opt.setQuestion(question);
                opt.setText(optionTexts.get(i));
                opt.setIsCorrect(correctOptionIndex != null && i == correctOptionIndex);
                optionRepository.save(opt);
            }
        }
        return question;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ExamResult> getResultByStudentAndExam(User student, Exam exam) {
        return examResultRepository.findByStudentAndExam(student, exam);
    }

    @Override
    public ExamResult submitExam(Integer examId, Map<String, String> formParams, User student) {
        Exam exam = examRepository.findById(examId)
                .orElseThrow(() -> new ResourceNotFoundException("Exam not found with id: " + examId));

        ExamResult result = new ExamResult();
        result.setStudent(student);
        result.setExam(exam);
        result.setScore(0);
        result = examResultRepository.save(result);

        List<Question> questions = questionRepository.findByExam(exam);
        int totalScore = 0;

        for (Question q : questions) {
            String selectedOptionIdStr = formParams.get("question_" + q.getId());
            if (selectedOptionIdStr != null) {
                Integer selectedOptionId = Integer.parseInt(selectedOptionIdStr);
                Option selectedOption = optionRepository.findById(selectedOptionId).orElse(null);
                
                if (selectedOption != null) {
                    StudentAnswer sa = new StudentAnswer(result, q, selectedOption);
                    studentAnswerRepository.save(sa);

                    if (Boolean.TRUE.equals(selectedOption.getIsCorrect())) {
                        totalScore += q.getMarks();
                    }
                }
            }
        }

        result.setScore(totalScore);
        return examResultRepository.save(result);
    }

    @Override
    @Transactional(readOnly = true)
    public List<StudentAnswer> getStudentAnswersByResult(ExamResult result) {
        return studentAnswerRepository.findByExamResult(result);
    }
}
