package com.example.lostfound.service;

import com.example.lostfound.model.LostItem;
import com.example.lostfound.model.User;
import com.example.lostfound.repository.LostItemRepository;
import com.example.lostfound.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class LostItemService {
    @Autowired private LostItemRepository itemRepo;
    @Autowired private UserRepository userRepo;

    @Value("${file.upload-dir}")
    private String uploadDir;

    public void saveItem(String title, String desc, String loc,
                         MultipartFile file, String username) throws Exception {
        String fn = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path target = Paths.get(uploadDir).resolve(fn);
        Files.write(target, file.getBytes());

        User u = userRepo.findByUsername(username);
        LostItem item = new LostItem();
        item.setTitle(title);
        item.setDescription(desc);
        item.setLocation(loc);
        item.setImagePath("/images/" + fn);
        item.setUploadedBy(u);
        itemRepo.save(item);
    }
    public void deleteItem(Long id) {
        itemRepo.deleteById(id);
    }

    public void resolveItem(Long id) {
        LostItem item = itemRepo.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid item ID: " + id));
        item.setResolved(true);
        itemRepo.save(item);
    }

    public LostItem findById(Long id) {
        return itemRepo.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid item ID: " + id));
    }

    public void updateItem(Long id, String title, String desc, String loc) {
        LostItem item = findById(id);
        item.setTitle(title);
        item.setDescription(desc);
        item.setLocation(loc);
        itemRepo.save(item);
    }
}
