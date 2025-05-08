package com.se.services;

import com.se.models.RoommatePreference;
import com.se.models.User;
import com.se.models.Role;
import com.se.repositories.RoommatePreferenceRepository;
import com.se.repositories.UserRepository;
import com.se.repositories.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoommateMatchingService {

    @Autowired
    private RoommatePreferenceRepository preferenceRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    /**
     * Submit preferences for a student.
     *
     * @param preference RoommatePreference object containing student preferences.
     * @return Saved RoommatePreference object.
     */
    public RoommatePreference submitPreferences(RoommatePreference preference) {
        if (preference == null || preference.getStudent() == null) {
            throw new IllegalArgumentException("Invalid preference data provided.");
        }

        Long roleId = preference.getStudent().getRole() != null ? preference.getStudent().getRole().getId() : null;
        if (roleId == null) {
            throw new RuntimeException("Role not provided for the student.");
        }

        Role role = roleRepository.findById(roleId).orElseThrow(() -> new RuntimeException("Role not found"));

        User student = (User) preference.getStudent();
        student.setRole(role);

        return preferenceRepository.save(preference);
    }

    /**
     * Retrieve preferences for a student by their ID.
     *
     * @param studentId ID of the student.
     * @return RoommatePreference object or null if not found.
     */
    public RoommatePreference getPreferencesByStudentId(Long studentId) {
        RoommatePreference preference = preferenceRepository.findByStudentId(studentId);
        if (preference == null) {
            throw new IllegalArgumentException("No preferences found for student ID: " + studentId);
        }
        return preference;
    }

    /**
     * Find the best roommate match based on preferences.
     *
     * @param studentId ID of the student for whom to find a match.
     * @return Best matching RoommatePreference object or null if no match found.
     */
    public RoommatePreference findBestMatch(Long studentId) {
        RoommatePreference studentPref = getPreferencesByStudentId(studentId);
        List<RoommatePreference> allPrefs = preferenceRepository.findAll();
        RoommatePreference bestMatch = null;
        int maxScore = -1;

        for (RoommatePreference other : allPrefs) {
            if (!other.getStudent().getId().equals(studentId)) {
                int score = calculateMatchScore(studentPref, other);
                if (score > maxScore) {
                    maxScore = score;
                    bestMatch = other;
                }
            }
        }

        if (bestMatch == null) {
            throw new IllegalArgumentException("No matching roommate found for student ID: " + studentId);
        }
        return bestMatch;
    }

    /**
     * Calculate match score between two RoommatePreference objects.
     * 
     * @param student RoommatePreference object of the student.
     * @param other   RoommatePreference object of another student.
     * @return Score indicating how well they match.
     */
    private int calculateMatchScore(RoommatePreference student, RoommatePreference other) {
        int score = 0;

        if (student.getSleepSchedule().equals(other.getSleepSchedule()))
            score++;
        if (student.getCleanliness().equals(other.getCleanliness()))
            score++;
        if (student.getStudyHabits().equals(other.getStudyHabits()))
            score++;
        if (student.getHobbies().equals(other.getHobbies()))
            score++;
        if (student.getDietary().equals(other.getDietary()))
            score++;
        if (student.getSleepingPreference().equals(other.getSleepingPreference()))
            score++;

        return score;
    }
}
