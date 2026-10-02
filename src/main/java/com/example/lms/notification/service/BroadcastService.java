package com.example.lms.notification.service;

import com.example.lms.notification.model.BroadcastLog;
import java.util.List;

public interface BroadcastService {
    int sendBroadcastEmail(String subject, String message, String audience);
    List<BroadcastLog> getRecentBroadcastLogs();
}
