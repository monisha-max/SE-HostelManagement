package com.se.controllers;

import com.se.models.RoommatePreference;
import com.se.models.User;
import com.se.repositories.UserRepository;
import com.se.services.RoommateMatchingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/roommate")
public class RoommateMatchingController {

    @Autowired
    private RoommateMatchingService roommateMatchingService;
    @Autowired private UserRepository userRepository;

    /**
     * Submit preferences for a student.
     *
     * @param preference RoommatePreference object.
     * @return Response entity with the result.
     */
    @PostMapping("/submit")
  public ResponseEntity<?> submitRoommatePreferences(@RequestBody RoommatePreference preference) {
    // pull in the real User (and its role) from the DB
    Long sid = preference.getStudent().getId();
    User student = userRepository.findById(sid)
      .orElseThrow(() -> new RuntimeException("Unknown student: " + sid));
    preference.setStudent(student);

        try {
            RoommatePreference savedPreference = roommateMatchingService.submitPreferences(preference);
            return new ResponseEntity<>(savedPreference, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * Get roommate preferences for a student by studentId.
     *
     * @param studentId ID of the student.
     * @return RoommatePreference object or a message if not found.
     */
    @GetMapping("/{studentId}")
    public ResponseEntity<?> getRoommatePreferences(@PathVariable Long studentId) {
        try {
            RoommatePreference preference = roommateMatchingService.getPreferencesByStudentId(studentId);
            return new ResponseEntity<>(preference, HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    /**
     * Get the best match for a student based on their preferences.
     *
     * @param studentId ID of the student.
     * @return Best matching RoommatePreference object.
     */
    @GetMapping("/match/{studentId}")
    public ResponseEntity<?> getBestMatch(@PathVariable Long studentId) {
        try {
            RoommatePreference bestMatch = roommateMatchingService.findBestMatch(studentId);
            return new ResponseEntity<>(bestMatch, HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
