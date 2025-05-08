package com.se.controllers;

import com.se.models.FoodRequest;
import com.se.services.FoodRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/food-requests")
public class FoodRequestController {

    @Autowired
    private FoodRequestService foodRequestService;

    @PostMapping("/create")
    public FoodRequest createFoodRequest(@RequestBody FoodRequest foodRequest) {
        return foodRequestService.createFoodRequest(foodRequest);
    }

    @GetMapping("/all")
    public List<FoodRequest> getAllFoodRequests() {
        return foodRequestService.getAllFoodRequests();
    }

    @GetMapping("/{id}")
    public FoodRequest getFoodRequestById(@PathVariable Long id) {
        return foodRequestService.getFoodRequestById(id);
    }

    @DeleteMapping("/{id}")
    public String deleteFoodRequest(@PathVariable Long id) {
        foodRequestService.deleteFoodRequest(id);
        return "Food request deleted successfully!";
    }

    @PutMapping("/{id}")
    public FoodRequest updateFoodRequest(@PathVariable Long id,@RequestBody FoodRequest req) {
        req.setId(id);
        return foodRequestService.createFoodRequest(req);
}

}
