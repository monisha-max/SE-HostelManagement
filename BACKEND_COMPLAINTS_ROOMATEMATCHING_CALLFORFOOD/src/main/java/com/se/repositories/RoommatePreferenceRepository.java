package com.se.repositories;

import com.se.models.RoommatePreference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoommatePreferenceRepository extends JpaRepository<RoommatePreference, Long> {
    RoommatePreference findByStudentId(Long studentId);
}
