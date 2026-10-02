package com.example.lms.home.service.impl;

import com.example.lms.home.service.HomeService;
import org.springframework.stereotype.Service;

@Service
public class HomeServiceImpl implements HomeService {

    @Override
    public int calculate(String operation, int num1, int num2) {
        if ("add".equalsIgnoreCase(operation)) {
            return num1 + num2;
        } else if ("subtract".equalsIgnoreCase(operation)) {
            return num1 - num2;
        } else if ("multiply".equalsIgnoreCase(operation)) {
            return num1 * num2;
        }
        return 0;
    }
}
