// lib/models/complaint.dart

class Complaint {
  final int    id;
  final String studentId;
  final String category;
  final String description;
  final String status;

  Complaint({
    required this.id,
    required this.studentId,
    required this.category,
    required this.description,
    required this.status,
  });

  factory Complaint.fromJson(Map<String, dynamic> j) => Complaint(
        id:          (j['id']          as num).toInt(),
        studentId:   j['studentId']   as String,
        category:    j['category']    as String,
        description: j['description'] as String,
        status:      j['status']      as String,
      );

  /// When creating a new complaint, pass id=0 & backend auto-generates.
  /// When updating status, include the real id so JPA.save(...) updates.
  Map<String, dynamic> toJson({bool includeId = false}) {
    final m = <String, dynamic>{
      'studentId':   studentId,
      'category':    category,
      'description': description,
      'status':      status,
    };
    if (includeId) m['id'] = id;
    return m;
  }
}
