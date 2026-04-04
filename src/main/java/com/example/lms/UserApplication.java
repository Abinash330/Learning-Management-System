package com.example.lms;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api2")

//localhost:8080/api2/user/1
public class UserApplication {
    @GetMapping("/user/{id}")
    public String getUserById(@PathVariable int id) {
        return "User with ID: " + id;
    }
//localhost:8080/api2/product/1
    @GetMapping("/product/{id}")
    public String getProductById(@PathVariable int id) {
        return "Product with ID: " + id;
    }

    //localhost:8080/api2/search?id=12
    // Id 12 called query string
     @GetMapping("/search")
    public String search(@PathVariable("id") int id) {
        return "Search ID: " + id;
    }
}
