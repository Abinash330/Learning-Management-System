package com.example.lms.config;

import com.example.lms.model.Course;
import com.example.lms.model.Enrollment;
import com.example.lms.model.User;
import com.example.lms.model.VideoLecture;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.EnrollmentRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.repository.VideoLectureRepository;
import com.example.lms.service.VideoService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Optional;

/**
 * Seeds a sample video lecture, course, and enrollment so the
 * Video & Doubts module can be tested dynamically without any
 * manual upload step.
 *
 * Run order 2 — runs AFTER UserSeeder (order 1 implied by no @Order).
 */
@Configuration
public class VideoDataSeeder {

    /** Minimal valid MP4 file bytes (ftyp + mdat boxes — 43 bytes). */
    private static final byte[] TINY_MP4 = new byte[]{
        // ftyp box (size=20, 'ftyp', 'mp42', 0, 'mp42', 'isom')
        0,0,0,20, 0x66,0x74,0x79,0x70, 0x6d,0x70,0x34,0x32,
        0,0,0,0,  0x6d,0x70,0x34,0x32,
        // mdat box (size=8, 'mdat')
        0,0,0,8,  0x6d,0x64,0x61,0x74,
        // free box padding
        0,0,0,15, 0x66,0x72,0x65,0x65,
        0,0,0,0,  0,0,0
    };

    private static final String VIDEO_FILENAME    = "demo-intro-lecture.mp4";
    private static final String VIDEO_TITLE        = "Introduction to Java Programming";
    private static final String VIDEO_DESC         = "A comprehensive introduction to Java fundamentals: variables, loops, and OOP concepts.";
    private static final String COURSE_TITLE       = "Java Full Stack Development";
    private static final String FACULTY_EMAIL      = "faculty@lms.com";
    private static final String STUDENT_EMAIL      = "student@lms.com";

    @Bean
    @Order(10)
    CommandLineRunner seedVideoData(
            UserRepository userRepo,
            CourseRepository courseRepo,
            EnrollmentRepository enrollRepo,
            VideoLectureRepository videoRepo,
            VideoService videoService) {

        return args -> {
            System.out.println("🎬 VideoDataSeeder: Starting...");

            // ── 1. Resolve faculty user ──────────────────────────────────────
            Optional<User> facultyOpt = userRepo.findByEmail(FACULTY_EMAIL);
            if (facultyOpt.isEmpty()) {
                System.out.println("⚠️  VideoDataSeeder: Faculty " + FACULTY_EMAIL + " not found, skipping.");
                return;
            }
            User faculty = facultyOpt.get();

            // ── 2. Resolve student user ──────────────────────────────────────
            Optional<User> studentOpt = userRepo.findByEmail(STUDENT_EMAIL);
            if (studentOpt.isEmpty()) {
                System.out.println("⚠️  VideoDataSeeder: Student " + STUDENT_EMAIL + " not found, skipping.");
                return;
            }
            User student = studentOpt.get();

            // ── 3. Ensure course exists (create if missing) ──────────────────
            Course course;
            var existing = courseRepo.findByInstructor(faculty)
                    .stream()
                    .filter(c -> COURSE_TITLE.equals(c.getTitle()))
                    .findFirst();

            if (existing.isPresent()) {
                course = existing.get();
                System.out.println("✅ VideoDataSeeder: Course already exists: " + course.getTitle() + " (id=" + course.getId() + ")");
            } else {
                course = new Course();
                course.setTitle(COURSE_TITLE);
                course.setDescription("Master Java from basics to advanced Spring Boot applications.");
                course.setInstructor(faculty);
                course = courseRepo.save(course);
                System.out.println("✅ VideoDataSeeder: Created course: " + course.getTitle() + " (id=" + course.getId() + ")");
            }

            // ── 4. Enroll student in course (if not already) ─────────────────
            if (enrollRepo.findByStudentAndCourse(student, course).isEmpty()) {
                Enrollment enr = new Enrollment();
                enr.setStudent(student);
                enr.setCourse(course);
                enr.setProgress(0);
                enrollRepo.save(enr);
                System.out.println("✅ VideoDataSeeder: Enrolled " + student.getName() + " in " + course.getTitle());
            } else {
                System.out.println("✅ VideoDataSeeder: Student already enrolled in course.");
            }

            // ── 5. Create video file on disk ─────────────────────────────────
            Path uploadDir = Paths.get(videoService.getVideoUploadDir());
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }

            String storedName = "seed_" + VIDEO_FILENAME;
            Path videoPath = uploadDir.resolve(storedName);

            if (!Files.exists(videoPath)) {
                try (FileOutputStream fos = new FileOutputStream(videoPath.toFile())) {
                    fos.write(TINY_MP4);
                }
                System.out.println("✅ VideoDataSeeder: Created demo video file at: " + videoPath);
            } else {
                System.out.println("✅ VideoDataSeeder: Demo video file already exists.");
            }

            // ── 6. Seed video record in DB ───────────────────────────────────
            boolean alreadySaved = videoRepo.findByCourse(course)
                    .stream()
                    .anyMatch(v -> storedName.equals(v.getFileName()));

            if (!alreadySaved) {
                VideoLecture v = new VideoLecture();
                v.setTitle(VIDEO_TITLE);
                v.setDescription(VIDEO_DESC);
                v.setCourse(course);
                v.setUploadedBy(faculty);
                v.setFileName(storedName);
                v.setOriginalFileName(VIDEO_FILENAME);
                v.setFilePath("uploads/videos/" + storedName);
                v.setUploadedAt(LocalDateTime.now());
                videoRepo.save(v);
                System.out.println("✅ VideoDataSeeder: Saved video record → id=" + v.getId() + ", title=" + v.getTitle());
            } else {
                System.out.println("✅ VideoDataSeeder: Video record already exists in DB.");
            }

            System.out.println("🎬 VideoDataSeeder: Done. Test credentials:");
            System.out.println("   Faculty : " + FACULTY_EMAIL + " / faculty123");
            System.out.println("   Student : " + STUDENT_EMAIL + " / student123");
            System.out.println("   Admin   : admin@example.com / password");
        };
    }
}
