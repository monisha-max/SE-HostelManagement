import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../models/lost_item_model.dart';

class LostItemService {
  final String baseUrl = 'http://10.70.43.186:9092';

  Future<List<LostItem>> fetchLostItems() async {
    final res = await http.get(Uri.parse('$baseUrl/api/lost-items'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map((e) => LostItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch lost items');
    }
  }

  Future<bool> uploadLostItem({
    required String title,
    required String description,
    required String location,
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/lost-items'));
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: fileName));

    final response = await request.send();
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> deleteItem(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/api/lost-items/$id'));
    return res.statusCode == 200;
  }

  Future<bool> resolveItem(int id) async {
    final res = await http.put(Uri.parse('$baseUrl/api/lost-items/$id/resolve'));
    return res.statusCode == 200;
  }

  String getImageUrl(String imagePath) {
    return '$baseUrl/uploads/$imagePath';
  }
}
