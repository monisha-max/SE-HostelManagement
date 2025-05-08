package com.example.lostfound.controller;

import com.example.lostfound.model.WashingMachineBooking;
import com.example.lostfound.repository.UserRepository;
import com.example.lostfound.service.WashingMachineBookingService;
import com.example.lostfound.service.TimeSlotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDate;
import com.example.lostfound.model.User;


@Controller
@RequestMapping("/washing")
public class WashingBookingController {

    @Autowired private WashingMachineBookingService bookingService;
    @Autowired private UserRepository userRepo;

    @GetMapping("/calendar")
    public String calendar(
      @RequestParam(name="date", required=false)
      @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
      LocalDate date,
      Model m
    ) {
      if (date == null) date = LocalDate.now();
      m.addAttribute("date", date);
      m.addAttribute("cal", bookingService.getCalendar(date));
      return "washing_calendar";
    }

    @PostMapping("/book")
    public String doBook(
      @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
      @RequestParam("timeSlot") String timeSlot,
      @RequestParam("roomNumber") String roomNumber,
      Principal p,
      Model m
    ) {
      User u = userRepo.findByUsername(p.getName());
      // enforce 2 slots max per day
      if (bookingService.countByUserAndDate(u, date) >= 2) {
        m.addAttribute("error", "You can only book up to 2 slots per day.");
        // re‑show calendar with error
        m.addAttribute("date", date);
        m.addAttribute("cal", bookingService.getCalendar(date));
        return "washing_calendar";
      }
      WashingMachineBooking b = new WashingMachineBooking();
      b.setDate(date);
      b.setTimeSlot(timeSlot);
      b.setRoomNumber(roomNumber);
      b.setUser(u);
      bookingService.save(b);
      return "redirect:/washing/calendar?date=" + date;
    }
}
