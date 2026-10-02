package com.example.lms.doubt.service;

import com.example.lms.doubt.model.Doubt;
import com.example.lms.user.model.User;
import com.example.lms.video.model.VideoLecture;

import java.util.List;
import java.util.Optional;

public interface DoubtService {
    List<Doubt> getAllDoubts();
    List<Doubt> getDoubtsByVideo(VideoLecture video);
    List<Doubt> getDoubtsByVideos(List<VideoLecture> videos);
    Optional<Doubt> getDoubtById(Long id);
    Doubt askDoubt(Long videoId, String questionText, User student);
    Doubt replyDoubt(Long doubtId, String reply, User repliedBy);
    void deleteDoubt(Long id);
    long countByStatus(String status);
}
