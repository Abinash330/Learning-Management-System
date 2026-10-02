package com.example.lms.video.service.impl;

import com.example.lms.common.exception.ResourceNotFoundException;
import com.example.lms.course.model.Course;
import com.example.lms.course.repository.CourseRepository;
import com.example.lms.user.model.User;
import com.example.lms.video.model.VideoLecture;
import com.example.lms.video.repository.VideoLectureRepository;
import com.example.lms.video.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class VideoServiceImpl implements VideoService {

    private static final String UPLOAD_SUBDIR = "uploads/videos";

    private final VideoLectureRepository videoLectureRepository;
    private final CourseRepository courseRepository;

    @Autowired
    public VideoServiceImpl(VideoLectureRepository videoLectureRepository, CourseRepository courseRepository) {
        this.videoLectureRepository = videoLectureRepository;
        this.courseRepository = courseRepository;
    }

    @Override
    public String getVideoUploadDir() {
        return System.getProperty("user.dir") + "/" + UPLOAD_SUBDIR;
    }

    @Override
    public String saveVideoFile(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(getVideoUploadDir());
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        String storedName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path target = uploadPath.resolve(storedName);
        Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
        return storedName;
    }

    @Override
    public void deleteVideoFile(String storedName) {
        if (storedName == null || storedName.isBlank()) return;
        try {
            Path target = Paths.get(getVideoUploadDir()).resolve(storedName);
            Files.deleteIfExists(target);
        } catch (IOException ignored) {}
    }

    @Override
    @Transactional(readOnly = true)
    public List<VideoLecture> getAllVideos() {
        return videoLectureRepository.findAllByOrderByUploadedAtDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<VideoLecture> getVideosByCourse(Course course) {
        return videoLectureRepository.findByCourse(course);
    }

    @Override
    @Transactional(readOnly = true)
    public List<VideoLecture> getVideosByCourses(List<Course> courses) {
        if (courses == null || courses.isEmpty()) {
            return Collections.emptyList();
        }
        return videoLectureRepository.findByCourseIn(courses);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<VideoLecture> getVideoById(Long id) {
        return videoLectureRepository.findById(id);
    }

    @Override
    public VideoLecture saveVideo(VideoLecture video) {
        return videoLectureRepository.save(video);
    }

    @Override
    public VideoLecture uploadVideoLecture(String title, String description, Integer courseId, MultipartFile file, User user) throws IOException {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course not found with id: " + courseId));
        
        String storedName = saveVideoFile(file);
        VideoLecture v = new VideoLecture();
        v.setTitle(title);
        v.setDescription(description);
        v.setCourse(course);
        v.setUploadedBy(user);
        v.setFileName(storedName);
        v.setOriginalFileName(file.getOriginalFilename());
        v.setFilePath("uploads/videos/" + storedName);
        v.setUploadedAt(LocalDateTime.now());
        return videoLectureRepository.save(v);
    }

    @Override
    public VideoLecture updateVideoLecture(Long id, String title, String description, Integer courseId, MultipartFile file) throws IOException {
        VideoLecture v = videoLectureRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Video lecture not found with id: " + id));
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course not found with id: " + courseId));

        v.setTitle(title);
        v.setDescription(description);
        v.setCourse(course);

        if (file != null && !file.isEmpty()) {
            deleteVideoFile(v.getFileName());
            String storedName = saveVideoFile(file);
            v.setFileName(storedName);
            v.setOriginalFileName(file.getOriginalFilename());
            v.setFilePath("uploads/videos/" + storedName);
        }
        return videoLectureRepository.save(v);
    }

    @Override
    public void deleteVideo(Long id) {
        videoLectureRepository.findById(id).ifPresent(v -> {
            deleteVideoFile(v.getFileName());
            videoLectureRepository.delete(v);
        });
    }
}
