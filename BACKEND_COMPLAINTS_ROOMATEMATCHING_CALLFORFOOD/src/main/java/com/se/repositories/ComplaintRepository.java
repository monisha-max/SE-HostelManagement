package com.se.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.se.models.Complaint;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
}
