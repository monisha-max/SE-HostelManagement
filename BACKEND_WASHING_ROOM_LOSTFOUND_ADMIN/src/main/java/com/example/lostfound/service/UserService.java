package com.example.lostfound.service;

import com.example.lostfound.model.User;
import com.example.lostfound.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired private UserRepository userRepo;
    @Autowired private PasswordEncoder encoder;

    public void register(User u) {
        u.setPassword(encoder.encode(u.getPassword()));
        u.setRole("ROLE_STUDENT");
        userRepo.save(u);
    }
}
