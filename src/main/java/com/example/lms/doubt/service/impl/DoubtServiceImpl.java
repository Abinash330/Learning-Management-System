package com.example.lms.doubt.service.impl;

import com.example.lms.common.exception.ResourceNotFoundException;
import com.example.lms.doubt.model.Doubt;
import com.example.lms.doubt.repository.DoubtRepository;
import com.example.lms.doubt.service.DoubtService;
import com.example.lms.user.model.User;
import com.example.lms.video.model.VideoLecture;
import com.example.lms.video.repository.VideoLectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DoubtServiceImpl implements DoubtService {

    private final DoubtRepository doubtRepository;
    private final VideoLectureRepository videoLectureRepository;

    @Autowired
    public DoubtServiceImpl(DoubtRepository doubtRepository, VideoLectureRepository videoLectureRepository) {
        this.doubtRepository = doubtRepository;
        this.videoLectureRepository = videoLectureRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Doubt> getAllDoubts() {
        return doubtRepository.findAllByOrderByAskedAtDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Doubt> getDoubtsByVideo(VideoLecture video) {
        return doubtRepository.findByVideo(video);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Doubt> getDoubtsByVideos(List<VideoLecture> videos) {
        if (videos == null || videos.isEmpty()) {
            return Collections.emptyList();
        }
        return doubtRepository.findByVideoInOrderByAskedAtDesc(videos);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Doubt> getDoubtById(Long id) {
        return doubtRepository.findById(id);
    }

    @Override
    public Doubt askDoubt(Long videoId, String questionText, User student) {
        VideoLecture video = videoLectureRepository.findById(videoId)
                .orElseThrow(() -> new ResourceNotFoundException("Video not found with id: " + videoId));
        
        Doubt doubt = new Doubt();
        doubt.setQuestionText(questionText.trim());
        doubt.setStatus("OPEN");
        doubt.setAskedAt(LocalDateTime.now());
        doubt.setStudent(student);
        doubt.setVideo(video);
        return doubtRepository.save(doubt);
    }

    @Override
    public Doubt replyDoubt(Long doubtId, String reply, User repliedBy) {
        Doubt doubt = doubtRepository.findById(doubtId)
                .orElseThrow(() -> new ResourceNotFoundException("Doubt not found with id: " + doubtId));
        doubt.setReply(reply);
        doubt.setStatus("REPLIED");
        doubt.setRepliedAt(LocalDateTime.now());
        doubt.setRepliedBy(repliedBy);
        return doubtRepository.save(doubt);
    }

    @Override
    public void deleteDoubt(Long id) {
        doubtRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByStatus(String status) {
        return doubtRepository.countByStatus(status);
    }
}
