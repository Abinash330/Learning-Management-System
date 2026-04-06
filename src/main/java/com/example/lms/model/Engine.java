package com.example.lms.model;

import org.springframework.stereotype.Component;

@Component
public class Engine {

    public String start(){
        return "Engine Started";

    }  
    public String stop(){
        return "Engine Stopped";
    }
}
