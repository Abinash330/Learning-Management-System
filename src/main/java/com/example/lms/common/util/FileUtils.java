package com.example.lms.common.util;

import com.example.lms.common.exception.FileStorageException;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public final class FileUtils {

    private FileUtils() {}

    public static String storeFile(MultipartFile file, String uploadDir) {
        if (file == null || file.isEmpty()) {
            return null;
        }
        try {
            Path uploadPath = Paths.get(System.getProperty("user.dir"), uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            return fileName;
        } catch (IOException ex) {
            throw new FileStorageException("Could not store file " + file.getOriginalFilename() + ". Please try again!", ex);
        }
    }

    public static void deleteFile(String fileName, String uploadDir) {
        if (fileName == null || fileName.isBlank()) return;
        try {
            Path filePath = Paths.get(System.getProperty("user.dir"), uploadDir).resolve(fileName);
            Files.deleteIfExists(filePath);
        } catch (IOException ignored) {}
    }
}
