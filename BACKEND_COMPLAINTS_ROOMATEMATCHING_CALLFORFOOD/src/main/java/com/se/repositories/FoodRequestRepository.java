package com.se.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.se.models.FoodRequest;

@Repository
public interface FoodRequestRepository extends JpaRepository<FoodRequest, Long> {
}
