package com.example.lostfound.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
public class WashingMachineBooking {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate date;
    private String timeSlot;
    private String roomNumber;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Getters & setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}
