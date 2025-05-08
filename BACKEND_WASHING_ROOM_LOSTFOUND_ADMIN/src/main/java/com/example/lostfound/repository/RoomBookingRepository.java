package com.example.lostfound.repository;
import com.example.lostfound.model.User;


import com.example.lostfound.model.RoomBooking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface RoomBookingRepository
        extends JpaRepository<RoomBooking, Long> {
    Optional<RoomBooking> findByDateAndTimeSlot(LocalDate date, String timeSlot);

    int countByUserAndDate(User user, LocalDate date);
}
