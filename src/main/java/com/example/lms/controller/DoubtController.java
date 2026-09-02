package com.example.lms.controller;

import com.example.lms.model.Doubt;
import com.example.lms.model.User;
import com.example.lms.model.VideoLecture;
import com.example.lms.repository.DoubtRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.repository.VideoLectureRepository;
import com.example.lms.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
public class DoubtController {

    @Autowired private DoubtRepository doubtRepo;
    @Autowired private VideoLectureRepository videoRepo;
    @Autowired private UserRepository userRepository;
    @Autowired private CourseRepository courseRepository;

    // ── Faculty: doubts for their videos ──────────────────────────────────

    @GetMapping("/doubts")
    public String facultyDoubts(Model model, Principal principal) {
        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userRepository.findByEmail(principal.getName());
        if (uOpt.isPresent()) {
            User faculty = uOpt.get();
            List<com.example.lms.model.Course> myCourses = courseRepository.findByInstructor(faculty);
            List<VideoLecture> myVideos = videoRepo.findByCourseIn(
                    myCourses.isEmpty() ? List.of() : myCourses);
            List<Doubt> doubts = myVideos.isEmpty()
                    ? List.of()
                    : doubtRepo.findByVideoInOrderByAskedAtDesc(myVideos);
            model.addAttribute("doubts", doubts);
            model.addAttribute("name", faculty.getName());
            long openCount = doubts.stream().filter(d -> "OPEN".equals(d.getStatus())).count();
            model.addAttribute("openCount", openCount);
        }
        return "faculty-doubts";
    }

    // ── Admin: ALL doubts ─────────────────────────────────────────────────

    @GetMapping("/admin/doubts")
    public String adminDoubts(Model model) {
        List<Doubt> allDoubts = doubtRepo.findAllByOrderByAskedAtDesc();
        model.addAttribute("doubts", allDoubts);
        model.addAttribute("openCount", doubtRepo.countByStatus("OPEN"));
        model.addAttribute("repliedCount", doubtRepo.countByStatus("REPLIED"));
        return "admin-doubts";
    }

    // ── Reply to a doubt (Faculty & Admin) ────────────────────────────────

    @PostMapping("/doubts/reply/{id}")
    public String replyDoubt(
            @PathVariable Long id,
            @RequestParam("reply") String reply,
            Principal principal) {

        Optional<Doubt> dOpt = doubtRepo.findById(id);
        if (dOpt.isPresent() && principal != null) {
            Doubt d = dOpt.get();
            d.setReply(reply);
            d.setStatus("REPLIED");
            d.setRepliedAt(LocalDateTime.now());
            userRepository.findByEmail(principal.getName()).ifPresent(d::setRepliedBy);
            doubtRepo.save(d);
        }
        // Determine redirect based on role
        boolean isAdmin = userRepository.findByEmail(principal != null ? principal.getName() : "")
                .map(u -> "Admin".equalsIgnoreCase(u.getRole())).orElse(false);
        return isAdmin ? "redirect:/admin/doubts" : "redirect:/doubts";
    }

    // ── Delete a doubt (Admin only) ───────────────────────────────────────

    @PostMapping("/doubts/delete/{id}")
    public String deleteDoubt(@PathVariable Long id) {
        doubtRepo.deleteById(id);
        return "redirect:/admin/doubts";
    }
}
