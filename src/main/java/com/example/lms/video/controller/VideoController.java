package com.example.lms.video.controller;

import com.example.lms.course.model.Course;
import com.example.lms.course.service.CourseService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import com.example.lms.video.model.VideoLecture;
import com.example.lms.video.service.VideoService;
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
import java.util.List;
import java.util.Optional;

@Controller
public class VideoController {

    private final VideoService videoService;
    private final CourseService courseService;
    private final UserService userService;

    @Autowired
    public VideoController(VideoService videoService, CourseService courseService, UserService userService) {
        this.videoService = videoService;
        this.courseService = courseService;
        this.userService = userService;
    }

    // ── Faculty: list own videos ──────────────────────────────────────────
    @GetMapping("/videos")
    public String facultyVideos(Model model, Principal principal) {
        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userService.getUserByEmail(principal.getName());
        if (uOpt.isPresent()) {
            User faculty = uOpt.get();
            List<Course> myCourses = courseService.getCoursesByInstructor(faculty);
            List<VideoLecture> myVideos = videoService.getVideosByCourses(myCourses);
            model.addAttribute("videos", myVideos);
            model.addAttribute("courses", myCourses);
            model.addAttribute("name", faculty.getName());
        }
        return "faculty/videos";
    }

    // ── Admin: list ALL videos ─────────────────────────────────────────────
    @GetMapping("/admin/videos")
    public String adminVideos(Model model) {
        model.addAttribute("videos", videoService.getAllVideos());
        model.addAttribute("courses", courseService.getAllCourses());
        model.addAttribute("facultyList", userService.getUsersByRoleAndStatus("Faculty", 1));
        return "admin/videos";
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
        Optional<User> uOpt = userService.getUserByEmail(principal.getName());

        if (uOpt.isPresent() && file != null && !file.isEmpty()) {
            try {
                videoService.uploadVideoLecture(title, description, courseId, file, uOpt.get());
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
        Optional<VideoLecture> vOpt = videoService.getVideoById(id);
        if (vOpt.isEmpty()) return "redirect:/videos";
        model.addAttribute("video", vOpt.get());
        model.addAttribute("courses", courseService.getAllCourses());
        model.addAttribute("isAdmin", isAdmin(principal));
        return "faculty/video-edit";
    }

    @PostMapping("/videos/edit/{id}")
    public String editVideoSave(
            @PathVariable Long id,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("course_id") int courseId,
            @RequestParam(value = "file", required = false) MultipartFile file,
            Principal principal) {

        try {
            videoService.updateVideoLecture(id, title, description, courseId, file);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isAdmin(principal) ? "redirect:/admin/videos" : "redirect:/videos";
    }

    // ── Delete (Faculty & Admin) ───────────────────────────────────────────
    @PostMapping("/videos/delete/{id}")
    public String deleteVideo(@PathVariable Long id, Principal principal) {
        videoService.deleteVideo(id);
        return isAdmin(principal) ? "redirect:/admin/videos" : "redirect:/videos";
    }

    // ── Stream video with HTTP Range support (required for browser seeking) ─
    @GetMapping("/videos/stream/{id}")
    public ResponseEntity<Resource> streamVideo(
            @PathVariable Long id,
            @RequestHeader(value = HttpHeaders.RANGE, required = false) String rangeHeader) {

        Optional<VideoLecture> vOpt = videoService.getVideoById(id);
        if (vOpt.isEmpty()) return ResponseEntity.notFound().build();

        VideoLecture v = vOpt.get();
        File file = new File(videoService.getVideoUploadDir() + "/" + v.getFileName());
        if (!file.exists()) return ResponseEntity.notFound().build();

        long fileLength = file.length();
        String contentType = detectContentType(v.getOriginalFileName());

        // No Range header -> return full file
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
        return userService.getUserByEmail(principal.getName())
                .map(u -> "Admin".equalsIgnoreCase(u.getRole()))
                .orElse(false);
    }
}
