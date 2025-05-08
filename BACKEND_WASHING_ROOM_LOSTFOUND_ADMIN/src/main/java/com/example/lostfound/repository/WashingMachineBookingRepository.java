package com.example.lostfound.repository;
import com.example.lostfound.model.User;


import com.example.lostfound.model.WashingMachineBooking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface WashingMachineBookingRepository
        extends JpaRepository<WashingMachineBooking, Long> {
    Optional<WashingMachineBooking> findByDateAndTimeSlot(LocalDate date, String timeSlot);

    int countByUserAndDate(User user, LocalDate date);
}

