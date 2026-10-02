package com.example.lms.admin.service.impl;

import com.example.lms.admin.dto.AdminDashboardDTO;
import com.example.lms.admin.service.AdminService;
import com.example.lms.contact.model.Contact;
import com.example.lms.contact.repository.ContactRepository;
import com.example.lms.course.repository.CourseRepository;
import com.example.lms.enrollment.repository.EnrollmentRepository;
import com.example.lms.notice.repository.NoticeRepository;
import com.example.lms.user.model.User;
import com.example.lms.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final EnrollmentRepository enrollmentRepository;
    private final NoticeRepository noticeRepository;
    private final ContactRepository contactRepository;

    @Autowired
    public AdminServiceImpl(UserRepository userRepository,
                            CourseRepository courseRepository,
                            EnrollmentRepository enrollmentRepository,
                            NoticeRepository noticeRepository,
                            ContactRepository contactRepository) {
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.enrollmentRepository = enrollmentRepository;
        this.noticeRepository = noticeRepository;
        this.contactRepository = contactRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public AdminDashboardDTO getDashboardData() {
        AdminDashboardDTO dto = new AdminDashboardDTO();
        
        List<User> li = userRepository.findAll(Sort.by(Sort.Direction.ASC, "email"));
        dto.setUsersMaster(li);

        try {
            long activeUsersCount = userRepository.findByStatus(1).size();
            long facultyCount = userRepository.findByRoleIgnoreCase("Faculty").size();
            long studentCount = userRepository.findByRoleIgnoreCase("Student").size();
            long pendingCount  = userRepository.findByStatus(0).size();
            long totalUsers = userRepository.count();

            dto.setActiveUsersCount(activeUsersCount);
            dto.setFacultyCount(facultyCount);
            dto.setStudentCount(studentCount);
            dto.setPendingCount(pendingCount);
            dto.setTotalUsers(totalUsers);

            long totalCourses = courseRepository.count();
            dto.setTotalCourses(totalCourses);

            long totalEnrollments = enrollmentRepository.count();
            dto.setTotalEnrollments(totalEnrollments);

            int activeUsersPct = (totalUsers > 0) ? (int)((activeUsersCount / (double)totalUsers) * 100) : 0;
            int pendingUsersPct = (totalUsers > 0) ? (int)((pendingCount / (double)totalUsers) * 100) : 0;
            int enrolledPct = (totalUsers > 0) ? (int)(((double)totalEnrollments / (totalUsers * 2)) * 100) : 0;
            if(enrolledPct > 100) enrolledPct = 100;
            int coursesPct = (totalCourses > 0) ? (int)(((double)totalCourses / 50) * 100) : 0; 
            if(coursesPct > 100) coursesPct = 100;

            dto.setActiveUsersPct(activeUsersPct);
            dto.setPendingUsersPct(pendingUsersPct);
            dto.setEnrolledPct(enrolledPct);
            dto.setCoursesPct(coursesPct);

            List<User> recentUsers = userRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
            if(recentUsers.size() > 6) recentUsers = recentUsers.subList(0, 6);
            dto.setRecentUsers(recentUsers);

            long adminCount = userRepository.findByRoleIgnoreCase("Admin").size();
            dto.setAdminCount(adminCount);

            dto.setRecentNotices(noticeRepository.findTop4ByOrderByNoticeDateDesc());

            List<Contact> recentContacts = contactRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
            if(recentContacts.size() > 4) recentContacts = recentContacts.subList(0, 4);
            dto.setRecentContacts(recentContacts);

        } catch (Exception e) {
            dto.setRecentUsers(Collections.emptyList());
            dto.setRecentNotices(Collections.emptyList());
            dto.setRecentContacts(Collections.emptyList());
        }

        return dto;
    }

    @Override
    public User createAdminUser(String name, String email, String role, String mobile, String password) {
        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setMobile(mobile);
        u.setPassword(password);
        u.setRole(role);
        u.setStatus(1);
        u.setIsOnline(0);
        return userRepository.save(u);
    }
}
