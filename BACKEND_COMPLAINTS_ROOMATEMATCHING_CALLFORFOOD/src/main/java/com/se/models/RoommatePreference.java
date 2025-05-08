package com.se.models;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "roommate_preferences")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RoommatePreference {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "student_id", referencedColumnName = "id")
    private User student;

    private String sleepSchedule;
    private String cleanliness;
    private String studyHabits;
    private String hobbies;
    private String dietary;
    private String sleepingPreference;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
    }

    public String getSleepSchedule() {
        return sleepSchedule;
    }

    public void setSleepSchedule(String sleepSchedule) {
        this.sleepSchedule = sleepSchedule;
    }

    public String getCleanliness() {
        return cleanliness;
    }

    public void setCleanliness(String cleanliness) {
        this.cleanliness = cleanliness;
    }

    public String getStudyHabits() {
        return studyHabits;
    }

    public void setStudyHabits(String studyHabits) {
        this.studyHabits = studyHabits;
    }

    public String getHobbies() {
        return hobbies;
    }

    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }

    public String getDietary() {
        return dietary;
    }

    public void setDietary(String dietary) {
        this.dietary = dietary;
    }

    public String getSleepingPreference() {
        return sleepingPreference;
    }

    public void setSleepingPreference(String sleepingPreference) {
        this.sleepingPreference = sleepingPreference;
    }
}
