package com.example.lms.notice.service.impl;

import com.example.lms.common.util.FileUtils;
import com.example.lms.notice.model.Notice;
import com.example.lms.notice.repository.NoticeRepository;
import com.example.lms.notice.service.NoticeService;
import com.example.lms.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

    private static final String UPLOAD_DIR_NOTICES = "uploads/notices";

    private final NoticeRepository noticeRepository;

    @Autowired
    public NoticeServiceImpl(NoticeRepository noticeRepository) {
        this.noticeRepository = noticeRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getAllNotices() {
        return noticeRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getAllNotices(Sort sort) {
        return noticeRepository.findAll(sort);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getTop3Notices() {
        return noticeRepository.findTop3ByOrderByIdDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getTop4RecentNotices() {
        return noticeRepository.findTop4ByOrderByNoticeDateDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getTop10Notices() {
        return noticeRepository.findTop10ByOrderByIdDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getNoticesByAudience(List<String> audiences) {
        if (audiences == null || audiences.isEmpty()) return Collections.emptyList();
        return noticeRepository.findByTargetAudienceInOrderByIdDesc(audiences);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> getNoticesByCreatedBy(User user) {
        return noticeRepository.findByCreatedByOrderByIdDesc(user);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notice> searchNotices(String query) {
        if (query == null || query.isBlank()) {
            return noticeRepository.findAll();
        }
        return noticeRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrderByIdDesc(query, query);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Notice> getNoticeById(Long id) {
        return noticeRepository.findById(id);
    }

    @Override
    public Notice createNotice(String title, String description, String targetAudience, MultipartFile file, User user) {
        Notice n = new Notice();
        n.setTitle(title);
        n.setDescription(description);
        n.setNoticeDate(LocalDate.now());
        n.setTargetAudience(targetAudience);
        n.setCreatedBy(user);

        if (file != null && !file.isEmpty()) {
            String storedFileName = FileUtils.storeFile(file, UPLOAD_DIR_NOTICES);
            n.setFileName(file.getOriginalFilename());
            n.setFilePath(storedFileName);
        }

        return noticeRepository.save(n);
    }

    @Override
    public Notice saveNotice(Notice notice) {
        return noticeRepository.save(notice);
    }

    @Override
    public void deleteNoticeById(Long id) {
        noticeRepository.findById(id).ifPresent(n -> {
            if (n.getFilePath() != null) {
                FileUtils.deleteFile(n.getFilePath(), UPLOAD_DIR_NOTICES);
            }
            noticeRepository.delete(n);
        });
    }

    @Override
    public void deleteNoticeByIdAndUser(Long id, User user) {
        noticeRepository.findById(id).ifPresent(n -> {
            if (n.getCreatedBy() != null && user != null && n.getCreatedBy().getId().equals(user.getId())) {
                if (n.getFilePath() != null) {
                    FileUtils.deleteFile(n.getFilePath(), UPLOAD_DIR_NOTICES);
                }
                noticeRepository.delete(n);
            }
        });
    }
}
