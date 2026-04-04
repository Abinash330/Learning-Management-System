package com.example.lms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestC {

    @GetMapping("/test2")
    public String test2(){
        return "test2";   // open test2.jsp
    }

    @GetMapping("/manage")
    public String manage(){
        return "manage";  // open manage.jsp
    }

}