class WashingSlot {
  final String timeSlot;
  final String? bookedBy; // e.g., "Room 45 - Gunashrita"

  WashingSlot({required this.timeSlot, this.bookedBy});

  factory WashingSlot.fromJson(String timeSlot, Map<String, dynamic>? data) {
    if (data == null) return WashingSlot(timeSlot: timeSlot);
    return WashingSlot(
      timeSlot: timeSlot,
      bookedBy: "Room ${data['roomNumber']} - ${data['username']}",
    );
  }
}
