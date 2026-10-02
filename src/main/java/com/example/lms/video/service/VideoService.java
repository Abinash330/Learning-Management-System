package com.example.lms.video.service;

import com.example.lms.course.model.Course;
import com.example.lms.user.model.User;
import com.example.lms.video.model.VideoLecture;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public interface VideoService {
    String getVideoUploadDir();
    String saveVideoFile(MultipartFile file) throws IOException;
    void deleteVideoFile(String storedName);
    List<VideoLecture> getAllVideos();
    List<VideoLecture> getVideosByCourse(Course course);
    List<VideoLecture> getVideosByCourses(List<Course> courses);
    Optional<VideoLecture> getVideoById(Long id);
    VideoLecture saveVideo(VideoLecture video);
    VideoLecture uploadVideoLecture(String title, String description, Integer courseId, MultipartFile file, User user) throws IOException;
    VideoLecture updateVideoLecture(Long id, String title, String description, Integer courseId, MultipartFile file) throws IOException;
    void deleteVideo(Long id);
}
