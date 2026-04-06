package com.example.lms.repository;

import com.example.lms.model.BroadcastLog;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class BroadcastLogRepositoryTest {

    @Autowired
    private BroadcastLogRepository broadcastLogRepository;

    @Test
    void shouldFindTop50ByOrderBySentAtDesc() {
        BroadcastLog log1 = new BroadcastLog();
        log1.setSubject("Subject 1");
        log1.setSentAt(LocalDateTime.now().minusDays(1));
        broadcastLogRepository.save(log1);

        BroadcastLog log2 = new BroadcastLog();
        log2.setSubject("Subject 2");
        log2.setSentAt(LocalDateTime.now());
        broadcastLogRepository.save(log2);

        List<BroadcastLog> logs = broadcastLogRepository.findTop50ByOrderBySentAtDesc();
        assertThat(logs).hasSize(2);
        assertThat(logs.get(0).getSubject()).isEqualTo("Subject 2"); // Desc order check
    }
}
