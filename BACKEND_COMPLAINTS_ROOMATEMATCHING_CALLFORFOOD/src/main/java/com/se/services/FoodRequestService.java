package com.se.services;

import com.se.models.FoodRequest;
import com.se.repositories.FoodRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoodRequestService {

    @Autowired
    private FoodRequestRepository foodRequestRepository;

    public FoodRequest createFoodRequest(FoodRequest foodRequest) {
        return foodRequestRepository.save(foodRequest);
    }

    public List<FoodRequest> getAllFoodRequests() {
        return foodRequestRepository.findAll();
    }

    public FoodRequest getFoodRequestById(Long id) {
        return foodRequestRepository.findById(id).orElse(null);
    }

    public void deleteFoodRequest(Long id) {
        foodRequestRepository.deleteById(id);
    }
}
