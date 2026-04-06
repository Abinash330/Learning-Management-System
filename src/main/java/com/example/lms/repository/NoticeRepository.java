package com.example.lms.repository;

import com.example.lms.model.Notice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long> {
    List<Notice> findTop3ByOrderByIdDesc();
    List<Notice> findTop4ByOrderByNoticeDateDesc();
    List<Notice> findTop10ByOrderByIdDesc();
    List<Notice> findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrderByIdDesc(String t, String d);
}
