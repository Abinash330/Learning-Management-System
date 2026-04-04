package com.example.lms;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class LmsApplication {
 
    @Autowired
    private GreetingService greetingService;
    @GetMapping("/greet/{name}")
    public String greetUser(@PathVariable String name) {
        return greetingService.generateGreeting(name);
    }
  @Autowired
  private Model m;
  @GetMapping("/car")
  public String m(){
    return m.drive();
  }


    // Basic API
    @GetMapping("/hello")
    public String hello() {
        return "Welcome to LMS Application!";
    }

    // Personalized API
    @GetMapping("/hi")
    public String hi() {
        return "Welcome Abinash Application!";
    }

    // Path Variable Example
    @GetMapping("/welcome/{name}")
    public String welcomeUser(@PathVariable String name) {
        return "Welcome " + name + " to LMS!";
    }

    // Request Param Example
    @GetMapping("/course")
    public String courseInfo(
            @RequestParam String courseName,
            @RequestParam int duration) {

        return "Course: " + courseName + ", Duration: " + duration + " months";
    }

    // Return JSON Object
    @GetMapping("/student")
    public Map<String, Object> studentDetails() {
        Map<String, Object> student = new HashMap<>();
        student.put("id", 101);
        student.put("name", "Abinash Kar");
        student.put("course", "MCA");
        student.put("semester", 2);
        return student;
    }

    // Return List of Courses
    @GetMapping("/courses")
    public List<String> courses() {
        return Arrays.asList(
                "Java Full Stack",
                "Spring Boot",
                "React",
                "Database Management"
        );
    }

    @GetMapping("/add")
    public String add(
            // localhost:8081/add?f=10&g=20
            @RequestParam("f") int c,
            @RequestParam("g") int d) {

        return "Addition of " + c + " and " + d + " is: " + (c + d);
    }

    @PostMapping("/add2")
    public String add2(
            @RequestParam int a,
            @RequestParam int b) {

        return "Sum = " + (a + b);
    }

    // RequestMapping (older way)
    @RequestMapping(method = RequestMethod.GET, path = "/abc")
    public String abc() {
        return "This is ABC endpoint using RequestMapping";
    }

    // Multiple URL mapping (commented out to allow AnoController to serve the JSP index page)
    // @GetMapping({ "", "/", "/index", "/home" })
    // public String index() {
    //     return "Multiple URL Mapping Example";
    // }

    @RestController
    @RequestMapping("/api")
    public static class ApiController {

        @RequestMapping("/hello")
        public String hello() {
            return "Hello from /api/hello endpoint!";
        }

        // @GetMapping("/greet")
        // public String greet() {
        //     return "Hello Abhi!";
        // }

        @PostMapping("/submit")
        public String submit(@RequestBody String data) {
            return "Hello from POST method!";
        }

        @PutMapping("/update")
        public String update(@RequestBody String data) {
            return "Hello from PUT method!";
        }

        @DeleteMapping("/delete")
        public String delete() {
            return "Hello from DELETE method!";
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(LmsApplication.class, args);
    }
}
