// src/main/java/com/example/lostfound/controller/LostItemController.java
package com.example.lostfound.controller;

import com.example.lostfound.repository.LostItemRepository;
import com.example.lostfound.service.LostItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;

@Controller
public class LostItemController {
    @Autowired private LostItemService itemService;
    @Autowired private LostItemRepository itemRepo;

    @GetMapping({"/","/items"})
    public String viewItems(Model m) {
        m.addAttribute("items", itemRepo.findByResolvedFalse());
        return "items";
    }

    @GetMapping("/upload")
    public String showUpload() { return "upload"; }

    @PostMapping("/upload")
    public String doUpload(@RequestParam String title,
                           @RequestParam String description,
                           @RequestParam String location,
                           @RequestParam("image") MultipartFile file,
                           Principal p) throws Exception {
        itemService.saveItem(title, description, location, file, p.getName());
        return "redirect:/items";
    }

    
}
