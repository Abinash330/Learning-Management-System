package com.example.lms.video.repository;

import com.example.lms.course.model.Course;
import com.example.lms.user.model.User;
import com.example.lms.video.model.VideoLecture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VideoLectureRepository extends JpaRepository<VideoLecture, Long> {
    List<VideoLecture> findByCourse(Course course);
    List<VideoLecture> findByCourseIn(List<Course> courses);
    List<VideoLecture> findByUploadedBy(User user);
    List<VideoLecture> findAllByOrderByUploadedAtDesc();
    List<VideoLecture> findByCourseOrderByUploadedAtDesc(Course course);
    long countByCourse(Course course);
}
