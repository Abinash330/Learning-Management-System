package com.example.lms.notice.repository;

import com.example.lms.notice.model.Notice;
import com.example.lms.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long> {
    List<Notice> findTop3ByOrderByIdDesc();
    List<Notice> findTop4ByOrderByNoticeDateDesc();
    List<Notice> findTop10ByOrderByIdDesc();
    List<Notice> findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrderByIdDesc(String t, String d);
    List<Notice> findByTargetAudienceInOrderByIdDesc(List<String> targetAudiences);
    List<Notice> findByCreatedByOrderByIdDesc(User user);
}
