class RoomBooking {
  final String timeSlot;
  final String? bookedBy;

  RoomBooking({required this.timeSlot, this.bookedBy});

  factory RoomBooking.fromJson(Map<String, dynamic> json) {
    return RoomBooking(
      timeSlot: json['timeSlot'],
      bookedBy: json['roomNumber'] != null && json['user'] != null
          ? 'Room ${json['roomNumber']} - ${json['user']['name']}'
          : null,
    );
  }
}
