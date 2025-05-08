// src/main/java/com/example/lostfound/repository/LostItemRepository.java
package com.example.lostfound.repository;

import com.example.lostfound.model.LostItem;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LostItemRepository extends JpaRepository<LostItem, Long> {
    List<LostItem> findByResolvedFalse();
}
