package com.example.lms.notice.controller;

import com.example.lms.notice.model.Notice;
import com.example.lms.notice.service.NoticeService;
import com.example.lms.user.model.User;
import com.example.lms.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.List;

@Controller
public class NoticeController {

    private final NoticeService noticeService;
    private final UserService userService;

    @Autowired
    public NoticeController(NoticeService noticeService, UserService userService) {
        this.noticeService = noticeService;
        this.userService = userService;
    }

    @GetMapping("/api/notices")
    @ResponseBody
    public ResponseEntity<List<Notice>> getNoticesApi() {
        return ResponseEntity.ok(noticeService.getTop10Notices());
    }

    @GetMapping("/admin-notices")
    public String adminNotices(Model model) {
        model.addAttribute("notices", noticeService.getAllNotices(Sort.by(Sort.Direction.DESC, "id")));
        return "admin/notices";
    }

    @PostMapping("/admin-notices/add")
    public String adminNoticesAdd(
            @RequestParam("title") String title, 
            @RequestParam("description") String description,
            @RequestParam("targetAudience") String targetAudience,
            @RequestParam(value = "file", required = false) MultipartFile file,
            Principal principal) {
            
        User user = (principal != null) ? userService.getUserByEmail(principal.getName()).orElse(null) : null;
        noticeService.createNotice(title, description, targetAudience, file, user);
        return "redirect:/admin-notices";
    }

    @PostMapping("/admin-notices/delete")
    public String adminNoticesDelete(@RequestParam("id") Long id) {
        noticeService.deleteNoticeById(id);
        return "redirect:/admin-notices";
    }
}
