package com.se.controllers;

import com.se.models.User;
import com.se.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public String register(@RequestBody Map<String, String> payload) {
        User user = new User();
        user.setLoginId(payload.get("loginId"));
        user.setPassword(payload.get("password"));
        user.setName(payload.get("name"));

        return userService.register(user, payload.get("role"));
    }

    @PostMapping("/login")
    public String login(@RequestBody Map<String, String> credentials) {
        boolean isAuthenticated = userService.authenticate(credentials.get("loginId"), credentials.get("password"));
        return isAuthenticated ? "Login successful!" : "Invalid credentials!";
    }

    @GetMapping("/role/{loginId}")
    public String getUserRole(@PathVariable String loginId) {
        return userService.getUserRole(loginId);
    }
}
