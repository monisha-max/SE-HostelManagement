class FoodRequest {
  final int    id;
  final String studentId;      // <-- was int
  final String roomNumber;
  final String foodType;
  final String specialRequest;
  final String status;

  FoodRequest({
    required this.id,
    required this.studentId,
    required this.roomNumber,
    required this.foodType,
    required this.specialRequest,
    required this.status,
  });

  factory FoodRequest.fromJson(Map<String, dynamic> j) => FoodRequest(
        id:             j['id']            as int,
        studentId:      j['studentId']     .toString(), // ensure string
        roomNumber:     (j['roomNumber']    as String?) ?? '',
        foodType:       (j['foodType']      as String?) ?? '',
        specialRequest: (j['specialRequest']as String?) ?? '',
        status:         (j['status']        as String?) ?? '',
      );

  /// Always include status; if updating, include id as well.
  Map<String, dynamic> toJson({bool forUpdate = false}) {
    final m = <String, dynamic>{
      'studentId':      studentId,     // now a string
      'roomNumber':     roomNumber,
      'foodType':       foodType,
      'specialRequest': specialRequest,
      'status':         status,
    };
    if (forUpdate) {
      m['id'] = id;
    }
    return m;
  }

  /// For update button logic
  FoodRequest copyWith({
    int?    id,
    String? studentId,
    String? roomNumber,
    String? foodType,
    String? specialRequest,
    String? status,
  }) {
    return FoodRequest(
      id:             id             ?? this.id,
      studentId:      studentId      ?? this.studentId,
      roomNumber:     roomNumber     ?? this.roomNumber,
      foodType:       foodType       ?? this.foodType,
      specialRequest: specialRequest ?? this.specialRequest,
      status:         status         ?? this.status,
    );
  }
}
