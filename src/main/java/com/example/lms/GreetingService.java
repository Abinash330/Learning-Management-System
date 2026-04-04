package com.example.lms;

import org.springframework.stereotype.Component;

@Component
public class GreetingService {
    public String generateGreeting(String name) {
        return "Hello, " + name + "! Welcome to LMS!";
    }

    
}
