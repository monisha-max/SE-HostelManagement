// src/main/java/com/example/lostfound/controller/AuthController.java
package com.example.lostfound.controller;

import com.example.lostfound.model.User;
import com.example.lostfound.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {
    @Autowired private UserService userService;

    @GetMapping("/register")
    public String showRegister(Model m) {
        m.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(@ModelAttribute User u) {
        userService.register(u);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLogin() { return "login"; }
}
