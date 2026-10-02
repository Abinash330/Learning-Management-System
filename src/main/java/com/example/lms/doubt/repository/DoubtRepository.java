package com.example.lms.doubt.repository;

import com.example.lms.doubt.model.Doubt;
import com.example.lms.user.model.User;
import com.example.lms.video.model.VideoLecture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoubtRepository extends JpaRepository<Doubt, Long> {
    List<Doubt> findByVideo(VideoLecture video);
    List<Doubt> findByStudent(User student);
    List<Doubt> findByVideoIn(List<VideoLecture> videos);
    List<Doubt> findByStatus(String status);
    List<Doubt> findAllByOrderByAskedAtDesc();
    List<Doubt> findByVideoInOrderByAskedAtDesc(List<VideoLecture> videos);
    long countByStatus(String status);
}
