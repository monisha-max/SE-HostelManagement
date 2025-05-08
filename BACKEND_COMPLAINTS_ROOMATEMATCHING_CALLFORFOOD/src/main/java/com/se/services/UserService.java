package com.se.services;

import com.se.models.User;
import com.se.models.Role;
import com.se.repositories.UserRepository;
import com.se.repositories.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    public String register(User user, String roleName) {
        System.out.println(" Searching for role: " + roleName);

        Optional<Role> role = roleRepository.findByRoleName(roleName);

        if (role.isEmpty()) {
            System.out.println(" Role not found in DB: " + roleName);
            return "Invalid role!";
        }

        user.setRole(role.get());
        userRepository.save(user);
        System.out.println(" User registered successfully with role: " + roleName);
        return "User registered successfully!";
    }

    public boolean authenticate(String loginId, String password) {
        Optional<User> userOptional = userRepository.findByLoginId(loginId);

        if (userOptional.isEmpty()) {
            System.out.println(" User with loginId '" + loginId + "' NOT found in the database.");
            return false;
        } else {
            System.out.println(" User found: " + userOptional.get().getLoginId());
            System.out.println("Stored Password: " + userOptional.get().getPassword());
            System.out.println("Entered Password: " + password);
        }

        return userOptional.get().getPassword().equals(password);
    }

    public String getUserRole(String loginId) {
        Optional<User> userOptional = userRepository.findByLoginId(loginId);
        return userOptional.map(user -> user.getRole().getRoleName()).orElse("Role not found!");
    }

}
