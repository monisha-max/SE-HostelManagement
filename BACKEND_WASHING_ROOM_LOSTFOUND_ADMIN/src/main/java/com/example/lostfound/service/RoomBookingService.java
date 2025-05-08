package com.example.lostfound.service;

import com.example.lostfound.model.RoomBooking;
import com.example.lostfound.repository.RoomBookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import com.example.lostfound.model.User;


@Service
public class RoomBookingService {
    @Autowired private RoomBookingRepository repo;

    public void save(RoomBooking b) {
        repo.save(b);
    }

    public Map<String, RoomBooking> getCalendar(LocalDate date) {
        Map<String, RoomBooking> cal = new LinkedHashMap<>();
        for (String slot : TimeSlotService.getAll()) {
            RoomBooking rb = repo
                .findByDateAndTimeSlot(date, slot)
                .orElse(null);
            cal.put(slot, rb);
        }
        return cal;
    }
    public int countByUserAndDate(User user, LocalDate date) {
      return repo.countByUserAndDate(user, date);
    }
}
