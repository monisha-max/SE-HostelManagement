import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/washing_slot.dart';
import 'package:intl/intl.dart';

class WashingService {
  final String baseUrl = 'http://localhost:9092/washing';

  Future<List<WashingSlot>> fetchCalendar(DateTime date) async {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    final uri = Uri.parse('$baseUrl/calendar-app?date=$dateStr');

    final res = await http.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (res.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(res.body);
      return json.entries.map((e) {
        return WashingSlot.fromJson(e.key, e.value);
      }).toList();
    } else {
      throw Exception('Failed to load calendar');
    }
  }

  Future<String> bookSlot({
    required String timeSlot,
    required String roomNumber,
    required DateTime date,
    required String jsessionId,
  }) async {
    final uri = Uri.parse('$baseUrl/book-app');

    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'JSESSIONID=$jsessionId',
      },
      body: jsonEncode({
        'timeSlot': timeSlot,
        'roomNumber': roomNumber,
        'date': DateFormat('yyyy-MM-dd').format(date),
      }),
    );

    if (res.statusCode == 200) {
      return "Booking successful";
    } else {
      return res.body;
    }
  }
}
