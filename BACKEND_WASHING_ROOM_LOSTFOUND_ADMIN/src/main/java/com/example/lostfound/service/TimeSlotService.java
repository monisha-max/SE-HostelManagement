package com.example.lostfound.service;

import java.util.List;

public class TimeSlotService {
    public static List<String> getAll() {
        return List.of(
            "08:00-09:00","09:00-10:00","10:00-11:00",
            "11:00-12:00","12:00-13:00","13:00-14:00",
            "14:00-15:00","15:00-16:00","16:00-17:00"
        );
    }
}
