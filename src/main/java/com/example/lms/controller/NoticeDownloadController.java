package com.example.lms.controller;

import com.example.lms.model.Notice;
import com.example.lms.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;

@Controller
public class NoticeDownloadController {

    @Autowired
    private NoticeRepository noticeRepository;

    @GetMapping("/download/notice/{id}")
    public ResponseEntity<Resource> downloadNotice(@PathVariable Long id) {
        Optional<Notice> nOpt = noticeRepository.findById(id);
        if (nOpt.isEmpty() || nOpt.get().getFilePath() == null) {
            return ResponseEntity.notFound().build();
        }

        Notice notice = nOpt.get();
        try {
            String uploadDir = System.getProperty("user.dir") + "/uploads/notices";
            Path filePath = Paths.get(uploadDir).resolve(notice.getFilePath()).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists() || !resource.isReadable()) {
                return ResponseEntity.notFound().build();
            }

            String originalFileName = notice.getFileName() != null ? notice.getFileName() : "notice-file";

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + originalFileName + "\"")
                    .body(resource);

        } catch (MalformedURLException e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
