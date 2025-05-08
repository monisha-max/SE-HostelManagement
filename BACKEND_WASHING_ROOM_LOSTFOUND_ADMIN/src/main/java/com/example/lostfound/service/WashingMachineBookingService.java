package com.example.lostfound.service;

import com.example.lostfound.model.WashingMachineBooking;
import com.example.lostfound.repository.WashingMachineBookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import com.example.lostfound.model.User;


@Service
public class WashingMachineBookingService {
    @Autowired private WashingMachineBookingRepository repo;

    public void save(WashingMachineBooking b) {
        repo.save(b);
    }

    public Map<String, WashingMachineBooking> getCalendar(LocalDate date) {
        Map<String, WashingMachineBooking> cal = new LinkedHashMap<>();
        for (String slot : TimeSlotService.getAll()) {
            WashingMachineBooking wb = repo
                .findByDateAndTimeSlot(date, slot)
                .orElse(null);
            cal.put(slot, wb);
        }
        return cal;
    }

    public int countByUserAndDate(User user, LocalDate date) {
      return repo.countByUserAndDate(user, date);
    }
}
