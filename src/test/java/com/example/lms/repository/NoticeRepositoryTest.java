package com.example.lms.repository;

import com.example.lms.model.Notice;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.TestPropertySource;

import java.time.LocalDate;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
@TestPropertySource(locations = "classpath:application-test.properties")
public class NoticeRepositoryTest {

    @Autowired
    private NoticeRepository noticeRepository;

    @BeforeEach
    void setUp() {
        for (int i = 1; i <= 5; i++) {
            Notice notice = new Notice();
            notice.setTitle("Notice " + i);
            notice.setDescription("Description for " + i);
            notice.setNoticeDate(LocalDate.now().minusDays(5 - i));
            noticeRepository.save(notice);
        }
    }

    @AfterEach
    void tearDown() {
        noticeRepository.deleteAll();
    }

    @Test
    void shouldFindTop3ByOrderByIdDesc() {
        List<Notice> notices = noticeRepository.findTop3ByOrderByIdDesc();
        assertThat(notices).hasSize(3);
        assertThat(notices.get(0).getTitle()).isEqualTo("Notice 5"); 
    }

    @Test
    void shouldFindTop4ByOrderByNoticeDateDesc() {
        List<Notice> notices = noticeRepository.findTop4ByOrderByNoticeDateDesc();
        assertThat(notices).hasSize(4);
        assertThat(notices.get(0).getTitle()).isEqualTo("Notice 5"); 
    }

    @Test
    void shouldFindTop10ByOrderByIdDesc() {
        List<Notice> notices = noticeRepository.findTop10ByOrderByIdDesc();
        assertThat(notices).hasSize(5); 
    }

    @Test
    void shouldFindByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrderByIdDesc() {
        List<Notice> notices = noticeRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrderByIdDesc("Notice 2", "for 2");
        assertThat(notices).hasSize(1);
        assertThat(notices.get(0).getTitle()).isEqualTo("Notice 2");
    }
}
