package com.se.controllers;

import com.se.services.FAQService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

//@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/faqs")
public class FAQController {

    @Autowired
    private FAQService faqService;

    @GetMapping("/all")
    public List<Map<String, String>> getAllFAQs() {
        return faqService.getAllFAQs().stream()
                .map(faq -> Map.of("question", faq.getQuestion(), "answer", faq.getAnswer()))
                .toList();
    }

    @PostMapping("/ask")
    public Map<String, String> getAnswer(@RequestBody Map<String, String> request) {
        String question = request.get("question");
        String answer = faqService.getAnswerForQuestion(question);
        return Map.of("answer", answer);
    }
}
