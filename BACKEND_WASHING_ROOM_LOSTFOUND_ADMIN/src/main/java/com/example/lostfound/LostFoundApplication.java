package com.example.lostfound;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.lostfound.model.User;
import com.example.lostfound.repository.UserRepository;

@SpringBootApplication
public class LostFoundApplication {

    public static void main(String[] args) {
        SpringApplication.run(LostFoundApplication.class, args);
    }

    @Bean
    public CommandLineRunner createOrUpdateAdmin(UserRepository repo,
                                                PasswordEncoder pw) {
    return args -> {
        String name = "warden";
        String newPass = "123456789";
        User u = repo.findByUsername(name);
        if (u == null) {
        u = new User();
        u.setUsername(name);
        System.out.println("Created default admin: warden / " + newPass);
        } else {
        System.out.println("Updating warden password to: " + newPass);
        }
        u.setPassword(pw.encode(newPass));
        u.setRole("ROLE_ADMIN");
        repo.save(u);
    };
    }

}
