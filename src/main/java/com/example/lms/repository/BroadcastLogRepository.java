package com.example.lms.repository;

import com.example.lms.model.BroadcastLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface BroadcastLogRepository extends JpaRepository<BroadcastLog, Integer> {
    List<BroadcastLog> findTop50ByOrderBySentAtDesc();
}
