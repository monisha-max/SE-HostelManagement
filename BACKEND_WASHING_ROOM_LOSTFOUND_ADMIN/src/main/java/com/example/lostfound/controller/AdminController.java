package com.example.lostfound.controller;

import com.example.lostfound.model.LostItem;
import com.example.lostfound.model.WashingMachineBooking;
import com.example.lostfound.model.RoomBooking;
import com.example.lostfound.repository.LostItemRepository;
import com.example.lostfound.repository.WashingMachineBookingRepository;
import com.example.lostfound.repository.RoomBookingRepository;
import com.example.lostfound.service.LostItemService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    // — Repositories for dashboard tables —
    @Autowired
    private LostItemRepository lostItemRepository;

    @Autowired
    private WashingMachineBookingRepository washingMachineBookingRepository;

    @Autowired
    private RoomBookingRepository roomBookingRepository;

    // — Service for LostItem actions —
    @Autowired
    private LostItemService itemService;

    // —— DASHBOARD —— 
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        List<LostItem> items      = lostItemRepository.findAll();
        List<WashingMachineBooking> washings = washingMachineBookingRepository.findAll();
        List<RoomBooking> rooms   = roomBookingRepository.findAll();

        model.addAttribute("items",    items);
        model.addAttribute("washings", washings);
        model.addAttribute("rooms",    rooms);
        return "admin_dashboard";
    }

    // —— DELETE a LostItem —— 
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        itemService.deleteItem(id);
        return "redirect:/admin/dashboard";
    }

    // —— MARK a LostItem as resolved —— 
    @PostMapping("/resolve/{id}")
    public String resolve(@PathVariable Long id) {
        itemService.resolveItem(id);
        return "redirect:/admin/dashboard";
    }

    // —— SHOW the edit form —— 
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        model.addAttribute("item", itemService.findById(id));
        return "edit_item";
    }

    // —— PROCESS the edit form —— 
    @PostMapping("/edit/{id}")
    public String doEdit(
        @PathVariable Long id,
        @RequestParam String title,
        @RequestParam String description,
        @RequestParam String location
    ) {
        itemService.updateItem(id, title, description, location);
        return "redirect:/admin/dashboard";
    }
}
