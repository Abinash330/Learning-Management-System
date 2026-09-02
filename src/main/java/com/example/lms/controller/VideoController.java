package com.example.lms.controller;

import com.example.lms.model.Course;
import com.example.lms.model.User;
import com.example.lms.model.VideoLecture;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.repository.VideoLectureRepository;
import com.example.lms.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
public class VideoController {

    @Autowired private VideoLectureRepository videoRepo;
    @Autowired private CourseRepository courseRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private VideoService videoService;

    // ── Faculty: list own videos ──────────────────────────────────────────

    @GetMapping("/videos")
    public String facultyVideos(Model model, Principal principal) {
        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userRepository.findByEmail(principal.getName());
        if (uOpt.isPresent()) {
            User faculty = uOpt.get();
            List<Course> myCourses = courseRepository.findByInstructor(faculty);
            List<VideoLecture> myVideos = videoRepo.findByCourseIn(
                    myCourses.isEmpty() ? List.of() : myCourses);
            model.addAttribute("videos", myVideos);
            model.addAttribute("courses", myCourses);
            model.addAttribute("name", faculty.getName());
        }
        return "faculty-videos";
    }

    // ── Admin: list ALL videos ─────────────────────────────────────────────

    @GetMapping("/admin/videos")
    public String adminVideos(Model model) {
        model.addAttribute("videos", videoRepo.findAllByOrderByUploadedAtDesc());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("facultyList", userRepository.findByRoleIgnoreCaseAndStatus("Faculty", 1));
        return "admin-videos";
    }

    // ── Upload (Faculty & Admin) ───────────────────────────────────────────

    @PostMapping("/videos/upload")
    public String uploadVideo(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("course_id") int courseId,
            @RequestParam("file") MultipartFile file,
            Principal principal) {

        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userRepository.findByEmail(principal.getName());
        Optional<Course> cOpt = courseRepository.findById(courseId);

        if (uOpt.isPresent() && cOpt.isPresent() && file != null && !file.isEmpty()) {
            try {
                String storedName = videoService.saveVideoFile(file);
                VideoLecture v = new VideoLecture();
                v.setTitle(title);
                v.setDescription(description);
                v.setCourse(cOpt.get());
                v.setUploadedBy(uOpt.get());
                v.setFileName(storedName);
                v.setOriginalFileName(file.getOriginalFilename());
                v.setFilePath("uploads/videos/" + storedName);
                v.setUploadedAt(LocalDateTime.now());
                videoRepo.save(v);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        boolean adminRole = uOpt.map(u -> "Admin".equalsIgnoreCase(u.getRole())).orElse(false);
        return adminRole ? "redirect:/admin/videos" : "redirect:/videos";
    }

    // ── Edit form (Faculty & Admin) ────────────────────────────────────────

    @GetMapping("/videos/edit/{id}")
    public String editVideoForm(@PathVariable Long id, Model model, Principal principal) {
        Optional<VideoLecture> vOpt = videoRepo.findById(id);
        if (vOpt.isEmpty()) return "redirect:/videos";
        model.addAttribute("video", vOpt.get());
        model.addAttribute("courses", courseRepository.findAll());
        model.addAttribute("isAdmin", isAdmin(principal));
        return "video-edit";
    }

    @PostMapping("/videos/edit/{id}")
    public String editVideoSave(
            @PathVariable Long id,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("course_id") int courseId,
            @RequestParam(value = "file", required = false) MultipartFile file,
            Principal principal) {

        Optional<VideoLecture> vOpt = videoRepo.findById(id);
        Optional<Course> cOpt = courseRepository.findById(courseId);
        if (vOpt.isPresent() && cOpt.isPresent()) {
            VideoLecture v = vOpt.get();
            v.setTitle(title);
            v.setDescription(description);
            v.setCourse(cOpt.get());

            if (file != null && !file.isEmpty()) {
                videoService.deleteVideoFile(v.getFileName());
                try {
                    String storedName = videoService.saveVideoFile(file);
                    v.setFileName(storedName);
                    v.setOriginalFileName(file.getOriginalFilename());
                    v.setFilePath("uploads/videos/" + storedName);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            videoRepo.save(v);
        }
        return isAdmin(principal) ? "redirect:/admin/videos" : "redirect:/videos";
    }

    // ── Delete (Faculty & Admin) ───────────────────────────────────────────

    @PostMapping("/videos/delete/{id}")
    public String deleteVideo(@PathVariable Long id, Principal principal) {
        Optional<VideoLecture> vOpt = videoRepo.findById(id);
        vOpt.ifPresent(v -> {
            videoService.deleteVideoFile(v.getFileName());
            videoRepo.delete(v);
        });
        return isAdmin(principal) ? "redirect:/admin/videos" : "redirect:/videos";
    }

    // ── Stream video with HTTP Range support (required for browser seeking) ─

    @GetMapping("/videos/stream/{id}")
    public ResponseEntity<Resource> streamVideo(
            @PathVariable Long id,
            @RequestHeader(value = HttpHeaders.RANGE, required = false) String rangeHeader) {

        Optional<VideoLecture> vOpt = videoRepo.findById(id);
        if (vOpt.isEmpty()) return ResponseEntity.notFound().build();

        VideoLecture v = vOpt.get();
        File file = new File(videoService.getVideoUploadDir() + "/" + v.getFileName());
        if (!file.exists()) return ResponseEntity.notFound().build();

        long fileLength = file.length();
        String contentType = detectContentType(v.getOriginalFileName());

        // No Range header → return full file
        if (rangeHeader == null || rangeHeader.isBlank()) {
            Resource resource = new FileSystemResource(file);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + v.getOriginalFileName() + "\"")
                    .header(HttpHeaders.ACCEPT_RANGES, "bytes")
                    .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(fileLength))
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(resource);
        }

        // Parse "bytes=start-end"
        try {
            String rangeValue = rangeHeader.replace("bytes=", "").trim();
            String[] parts = rangeValue.split("-");
            long start = Long.parseLong(parts[0].trim());
            long end = (parts.length > 1 && !parts[1].trim().isEmpty())
                    ? Long.parseLong(parts[1].trim())
                    : Math.min(start + 1024 * 1024 - 1, fileLength - 1); // default 1 MB chunk
            end = Math.min(end, fileLength - 1);
            long contentLength = end - start + 1;

            byte[] data = readFileRange(file, start, contentLength);
            Resource rangedResource = new ByteArrayResource(data);

            return ResponseEntity.status(206) // 206 Partial Content
                    .header(HttpHeaders.CONTENT_RANGE, "bytes " + start + "-" + end + "/" + fileLength)
                    .header(HttpHeaders.ACCEPT_RANGES, "bytes")
                    .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(contentLength))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + v.getOriginalFileName() + "\"")
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(rangedResource);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────

    private String detectContentType(String filename) {
        if (filename == null) return "video/mp4";
        String lower = filename.toLowerCase();
        if (lower.endsWith(".webm")) return "video/webm";
        if (lower.endsWith(".ogg") || lower.endsWith(".ogv")) return "video/ogg";
        if (lower.endsWith(".mov")) return "video/quicktime";
        if (lower.endsWith(".avi")) return "video/x-msvideo";
        return "video/mp4";
    }

    private byte[] readFileRange(File file, long start, long length) throws IOException {
        byte[] data = new byte[(int) length];
        try (RandomAccessFile raf = new RandomAccessFile(file, "r")) {
            raf.seek(start);
            raf.readFully(data);
        }
        return data;
    }

    private boolean isAdmin(Principal principal) {
        if (principal == null) return false;
        return userRepository.findByEmail(principal.getName())
                .map(u -> "Admin".equalsIgnoreCase(u.getRole()))
                .orElse(false);
    }
}
