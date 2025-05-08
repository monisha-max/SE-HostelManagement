// lib/models/roommate_pref.dart

class RoommatePref {
  final int    id;
  final int    studentId;
  final String sleepSchedule;
  final String cleanliness;
  final String studyHabits;
  final String hobbies;
  final String dietary;
  final String sleepingPreference;

  RoommatePref({
    required this.id,
    required this.studentId,
    required this.sleepSchedule,
    required this.cleanliness,
    required this.studyHabits,
    required this.hobbies,
    required this.dietary,
    required this.sleepingPreference,
  });

  factory RoommatePref.fromJson(Map<String, dynamic> j) {
    // backend nests the student object
    final stu = (j['student'] ?? {}) as Map<String, dynamic>;
    return RoommatePref(
      id:                  j['id'] as int,
      studentId:           stu['id'] as int,
      sleepSchedule:       j['sleepSchedule']       as String? ?? '',
      cleanliness:         j['cleanliness']         as String? ?? '',
      studyHabits:         j['studyHabits']         as String? ?? '',
      hobbies:             j['hobbies']             as String? ?? '',
      dietary:             j['dietary']             as String? ?? '',
      sleepingPreference:  j['sleepingPreference']  as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    // **IMPORTANT**: wrap studentId in a `student` object exactly
    // as your controller reads: `preference.getStudent().getId()`
    return {
      "student": {
        "id": studentId
      },
      "sleepSchedule":      sleepSchedule,
      "cleanliness":        cleanliness,
      "studyHabits":        studyHabits,
      "hobbies":            hobbies,
      "dietary":            dietary,
      "sleepingPreference": sleepingPreference,
    };
  }
}
