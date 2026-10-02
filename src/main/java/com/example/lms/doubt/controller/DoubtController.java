package com.example.lms.doubt.controller;

import com.example.lms.course.model.Course;
import com.example.lms.course.service.CourseService;
import com.example.lms.doubt.model.Doubt;
import com.example.lms.doubt.service.DoubtService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import com.example.lms.video.model.VideoLecture;
import com.example.lms.video.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Controller
public class DoubtController {

    private final DoubtService doubtService;
    private final VideoService videoService;
    private final UserService userService;
    private final CourseService courseService;

    @Autowired
    public DoubtController(DoubtService doubtService,
                           VideoService videoService,
                           UserService userService,
                           CourseService courseService) {
        this.doubtService = doubtService;
        this.videoService = videoService;
        this.userService = userService;
        this.courseService = courseService;
    }

    // ── Faculty: doubts for their videos ──────────────────────────────────
    @GetMapping("/doubts")
    public String facultyDoubts(Model model, Principal principal) {
        if (principal == null) return "redirect:/login";
        Optional<User> uOpt = userService.getUserByEmail(principal.getName());
        if (uOpt.isPresent()) {
            User faculty = uOpt.get();
            List<Course> myCourses = courseService.getCoursesByInstructor(faculty);
            List<VideoLecture> myVideos = videoService.getVideosByCourses(myCourses);
            List<Doubt> doubts = doubtService.getDoubtsByVideos(myVideos);
            model.addAttribute("doubts", doubts);
            model.addAttribute("name", faculty.getName());
            long openCount = doubts.stream().filter(d -> "OPEN".equals(d.getStatus())).count();
            model.addAttribute("openCount", openCount);
        }
        return "faculty/doubts";
    }

    // ── Admin: ALL doubts ─────────────────────────────────────────────────
    @GetMapping("/admin/doubts")
    public String adminDoubts(Model model) {
        List<Doubt> allDoubts = doubtService.getAllDoubts();
        model.addAttribute("doubts", allDoubts);
        model.addAttribute("openCount", doubtService.countByStatus("OPEN"));
        model.addAttribute("repliedCount", doubtService.countByStatus("REPLIED"));
        return "admin/doubts";
    }

    // ── Reply to a doubt (Faculty & Admin) ────────────────────────────────
    @PostMapping("/doubts/reply/{id}")
    public String replyDoubt(
            @PathVariable Long id,
            @RequestParam("reply") String reply,
            Principal principal) {

        if (principal != null) {
            User user = userService.getUserByEmail(principal.getName()).orElse(null);
            doubtService.replyDoubt(id, reply, user);
        }
        
        boolean isAdmin = userService.getUserByEmail(principal != null ? principal.getName() : "")
                .map(u -> "Admin".equalsIgnoreCase(u.getRole())).orElse(false);
        return isAdmin ? "redirect:/admin/doubts" : "redirect:/doubts";
    }

    // ── Delete a doubt (Admin only) ───────────────────────────────────────
    @PostMapping("/doubts/delete/{id}")
    public String deleteDoubt(@PathVariable Long id) {
        doubtService.deleteDoubt(id);
        return "redirect:/admin/doubts";
    }
}
