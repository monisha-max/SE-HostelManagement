class LostItem {
  final int id;
  final String title;
  final String description;
  final String location;
  final String imagePath;
  final bool resolved;

  LostItem({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imagePath,
    required this.resolved,
  });

  factory LostItem.fromJson(Map<String, dynamic> json) {
    return LostItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      imagePath: json['imagePath'],
      resolved: json['resolved'] ?? false,
    );
  }
}
