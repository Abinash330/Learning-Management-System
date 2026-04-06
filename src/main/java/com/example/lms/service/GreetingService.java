package com.example.lms.service;

import org.springframework.stereotype.Component;

@Component
public class GreetingService {
    public String generateGreeting(String name) {
        return "Hello, " + name + "! Welcome to LMS!";
    }

    
}
