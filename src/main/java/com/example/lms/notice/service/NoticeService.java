package com.example.lms.notice.service;

import com.example.lms.notice.model.Notice;
import com.example.lms.user.model.User;
import org.springframework.data.domain.Sort;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

public interface NoticeService {
    List<Notice> getAllNotices();
    List<Notice> getAllNotices(Sort sort);
    List<Notice> getTop3Notices();
    List<Notice> getTop4RecentNotices();
    List<Notice> getTop10Notices();
    List<Notice> getNoticesByAudience(List<String> audiences);
    List<Notice> getNoticesByCreatedBy(User user);
    List<Notice> searchNotices(String query);
    Optional<Notice> getNoticeById(Long id);
    Notice createNotice(String title, String description, String targetAudience, MultipartFile file, User user);
    Notice saveNotice(Notice notice);
    void deleteNoticeById(Long id);
    void deleteNoticeByIdAndUser(Long id, User user);
}
