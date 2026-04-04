package com.example.lms;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class AnoController {

    // @GetMapping("/test")
    // public String test(Model model){
    // List<String> li = new ArrayList<>();
    // li.add("Abinash");
    // li.add("Richa");
    // li.add("Jubli");
    // model.addAttribute("data", li);
    // return "test";

    // }
    // Handle GET request for /test
    @GetMapping("/test")
    public ModelAndView test() {

        // Create list of names
        List<String> li = new ArrayList<>();
        li.add("Abinash");
        li.add("Richa");
        li.add("Jubli");

        // Create ModelAndView object
        ModelAndView obj = new ModelAndView();

        // Add attributes to model
        obj.addObject("roll", 1234);
        obj.addObject("name", "Abinash");

        // Get current date and time
        LocalDateTime now = LocalDateTime.now();
        obj.addObject("now", now);

        // Add list data
        obj.addObject("data", li);

        // Set JSP view name
        obj.setViewName("test");

        // Return ModelAndView
        return obj;
    }

    @PostMapping("calclulate")
    public String calclulate_data(Model model, @RequestParam("btn") String btn, @RequestParam("num1") int num1,
            @RequestParam("num2") int num2) {
        System.out.println("Calculate Data Processed using POST method");
        int result = 0;
        if (btn.equals("add")) {
            result = num1 + num2;
        } else if (btn.equals("subtract")) {
            result = num1 - num2;
        } else if (btn.equals("multiply")) {
            result = num1 * num2;
        }
        model.addAttribute("result", result);

        return "calclulate";

        // design to code - from
        // code to design - model
    }

    @GetMapping("/calclulate")
    public String calclulate() {
        System.out.println("Calculate Data Processed using GET method");
        return "calclulate";
    }

    @GetMapping({"/", "/index"})
    public String index() {
        return "index";
    }



    @Controller
    public class ContactController {

        @GetMapping("/contact")
        public String contact() {
            return "contact";
        }

        @PostMapping("/contact")
        public String contactSave(
                @RequestParam("name") String name,
                @RequestParam("email") String email,
                @RequestParam("mobile") String mobile,
                @RequestParam("subject") String subject,
                @RequestParam("message") String message,
                Model model) {

            String sql = "INSERT INTO contact (name, email, mobile, subject, message) VALUES (?, ?, ?, ?, ?)";

            jdbc.update(sql, name, email, mobile, subject, message);

            model.addAttribute("sms", "Contact saved successfully ");

            return "contact";
        }
    }

    @GetMapping("/welcome")
    public String welcome() {
        return "welcome";
    }
    // @GetMapping("/login")
    // public String login() {
    // return "login";
    // }

    // @PostMapping("/login")
    // public String login_check(
    // @RequestParam("username") String name,
    // @RequestParam("password") String password,
    // Model model) {

    // String sql = "select * from user_master where name='"
    // + name + "' and password='" + password + "'";

    // List<Map<String, Object>> user = jdbc.queryForList(sql);

    // if (user.size() > 0) {
    // return "welcome";
    // } else {
    // model.addAttribute("sms", "Invalid Username or Password");
    // return "login";
    // }
    // }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    // recive user id and password
    public String login_chk(HttpSession session, @RequestParam("email") String email,
            @RequestParam("password") String password,
            Model model) {

        ArrayList<String> ali = new ArrayList<String>();
        String sql = "select * from user_master where email='" + email + "' and password='" + password + "'";
        // get match data from db
        jdbc.query(sql, new RowMapper<String>() {
            public String mapRow(ResultSet rs, int rowNum) throws SQLException {
                ali.add(rs.getString(1)); // id rs 1 is eq to ali 0 // ali[0] content id
                ali.add(rs.getString(2)); // name // ali[1] content name
                ali.add(rs.getString(3)); // user id / email // ali[2] content email
                ali.add(rs.getString(4)); // mobile // ali[3] content mobile
                ali.add(rs.getString(6)); // role // ali[4] content role
                ali.add(rs.getString(7)); // status // ali[5] content status
                return "";
            }
        });

        // if match
        if (!ali.isEmpty()) {
            // success // chk the status is 1 or not
            if (ali.get(5).equals("1")) { // if status 1 // active user
                session.setAttribute("name", ali.get(1));
                session.setAttribute("email", ali.get(2));

                // Set user to online status
                jdbc.execute("UPDATE user_master SET is_online=1 WHERE email='" + email + "'");

                if (ali.get(4).equalsIgnoreCase("student")) { // chk the role // if stude
                    return "sdashboard"; // student dashboard
                }
                if (ali.get(4).equalsIgnoreCase("faculty")) { // chk the role // if facu
                    return "fdashboard"; // faculty dashboard
                }
                if (ali.get(4).equalsIgnoreCase("admin")) { // chk the role // if student
                    return "adashboard"; // admin dashboard
                }
            } else {
                model.addAttribute("output", "Please contact your admin to active your account."); // inactive user by
                                                                                                   // admin
            }

        } else {
            // no match // invalid
            model.addAttribute("output", "Invalid email or password.");
        }
        System.out.println("chk login...");
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @Autowired
    JdbcTemplate jdbc;

    @PostMapping("/register")
    public String register_save(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("mobile") String mobile,
            @RequestParam("password") String password,
            @RequestParam("role") String role,
            Model model) {

        jdbc.execute("INSERT INTO user_master(name,email,mobile,password,role,status) VALUES('"
                + name + "','"
                + email + "','"
                + mobile + "','"
                + password + "','"
                + role + "','0')");

        model.addAttribute("output", "Registration complete! Please wait for admin approval to login.");

        return "login";
    }

    @GetMapping("/faq")
    public String faq() {
        return "faq";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email");
        if (email != null) {
            jdbc.execute("UPDATE user_master SET is_online=0 WHERE email='" + email + "'");
        }
        session.invalidate();
        model.addAttribute("output", "You have successfully logged out.");
        return "login";
    }

}
