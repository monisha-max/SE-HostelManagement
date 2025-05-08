package com.se.models;

import javax.persistence.*;

@Entity
@Table(name = "food_request_mst") 
public class FoodRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "student_id", nullable = false)
    private String studentId; 

    @Column(name = "room_number", nullable = false)
    private String roomNumber; 

    @Column(name = "food_type", nullable = false)
    private String foodType;

    @Column(name = "special_request")
    private String specialRequest;

    @Column(name = "status", nullable = false)
    private String status;

    public FoodRequest() {
    }

    public FoodRequest(String studentId, String roomNumber, String foodType, String specialRequest, String status) {
        this.studentId = studentId;
        this.roomNumber = roomNumber;
        this.foodType = foodType;
        this.specialRequest = specialRequest;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getFoodType() {
        return foodType;
    }

    public void setFoodType(String foodType) {
        this.foodType = foodType;
    }

    public String getSpecialRequest() {
        return specialRequest;
    }

    public void setSpecialRequest(String specialRequest) {
        this.specialRequest = specialRequest;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
