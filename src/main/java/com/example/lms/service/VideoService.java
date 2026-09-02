package com.example.lms.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class VideoService {

    private static final String UPLOAD_SUBDIR = "uploads/videos";

    public String getVideoUploadDir() {
        return System.getProperty("user.dir") + "/" + UPLOAD_SUBDIR;
    }

    /**
     * Saves the uploaded video file to disk.
     * @return the stored file name (UUID-prefixed)
     */
    public String saveVideoFile(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(getVideoUploadDir());
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        String storedName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path target = uploadPath.resolve(storedName);
        Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
        return storedName;
    }

    /**
     * Deletes a stored video file from disk. Silently ignores if not found.
     */
    public void deleteVideoFile(String storedName) {
        if (storedName == null || storedName.isBlank()) return;
        try {
            Path target = Paths.get(getVideoUploadDir()).resolve(storedName);
            Files.deleteIfExists(target);
        } catch (IOException ignored) {}
    }
}
