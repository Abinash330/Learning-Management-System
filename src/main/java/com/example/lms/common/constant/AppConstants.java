package com.example.lms.common.constant;

public final class AppConstants {

    private AppConstants() {
        // Prevent instantiation
    }

    public static final String ROLE_ADMIN = "Admin";
    public static final String ROLE_FACULTY = "Faculty";
    public static final String ROLE_STUDENT = "Student";

    public static final String STATUS_LIVE = "Live";
    public static final String STATUS_DRAFT = "Draft";
    public static final String STATUS_SUBMITTED = "submitted";
    public static final String STATUS_GRADED = "graded";
    public static final String STATUS_OPEN = "OPEN";
    public static final String STATUS_REPLIED = "REPLIED";

    public static final String AUDIENCE_ALL = "ALL";
    public static final String AUDIENCE_STUDENT = "STUDENT";
    public static final String AUDIENCE_FACULTY = "FACULTY";

    public static final String UPLOAD_DIR_VIDEOS = "uploads/videos";
    public static final String UPLOAD_DIR_ASSIGNMENTS = "uploads/assignments";
    public static final String UPLOAD_DIR_NOTICES = "uploads/notices";
    public static final String UPLOAD_DIR_PROFILES = "uploads/profiles";
}
