package com.example.lms.service;

import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

public class GreetingServiceTest {

    private final GreetingService greetingService = new GreetingService();

    @Test
    void shouldGenerateGreeting() {
        String result = greetingService.generateGreeting("John");
        assertThat(result).isEqualTo("Hello, John! Welcome to LMS!");
    }
}
