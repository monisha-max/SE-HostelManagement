// lib/services/api_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/complaint.dart';
import '../models/food_request.dart';
import '../models/faq_item.dart';
import '../models/roommate_pref.dart';

class ApiService {
  /// If your backend is served at
  ///   http://localhost:8080/hostel_management/api
  /// then include that entire path here:
  static const String _baseUrl = 'http://localhost:8080/hostel_management/api';

  // ─── AUTH ──────────────────────────────────────────────────────────

  Future<String> register({
    required String loginId,
    required String password,
    required String name,
    required String role,
  }) async {
    final uri = Uri.parse('$_baseUrl/auth/register');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'loginId': loginId,
        'password': password,
        'name': name,
        'role': role,
      }),
    );
    if (resp.statusCode == 200) return resp.body;
    throw Exception('Signup failed [${resp.statusCode}]: ${resp.body}');
  }

  Future<String> login(String loginId, String password) async {
    final uri = Uri.parse('$_baseUrl/auth/login');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'loginId': loginId, 'password': password}),
    );
    if (resp.statusCode == 200) return resp.body;
    throw Exception('Login failed [${resp.statusCode}]: ${resp.body}');
  }

  Future<String> getUserRole(String loginId) async {
    final uri = Uri.parse('$_baseUrl/auth/role/$loginId');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) return resp.body;
    throw Exception('Fetch role failed [${resp.statusCode}]: ${resp.body}');
  }

  // ─── COMPLAINTS ────────────────────────────────────────────────────

  Future<List<Complaint>> fetchComplaints() async {
    final uri = Uri.parse('$_baseUrl/complaints/all');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List<dynamic> data = json.decode(resp.body);
      return data.map((j) => Complaint.fromJson(j)).toList();
    }
    throw Exception('Fetch complaints failed [${resp.statusCode}]');
  }

  /// Insert or update a complaint.
  Future<Complaint> createComplaint(Complaint c) async {
    final uri = Uri.parse('$_baseUrl/complaints/create');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(c.toJson(includeId: c.id != 0)),
    );
    if (resp.statusCode == 200) {
      return Complaint.fromJson(json.decode(resp.body));
    }
    throw Exception('Create/update complaint failed [${resp.statusCode}]: ${resp.body}');
  }


  Future<void> deleteComplaint(int id) async {
    final uri = Uri.parse('$_baseUrl/complaints/$id');
    final resp = await http.delete(uri);
    if (resp.statusCode != 200) {
      throw Exception('Delete complaint failed [${resp.statusCode}]');
    }
  }

  

  // ─── FOOD REQUESTS ─────────────────────────────────────────────────

  Future<List<FoodRequest>> fetchFoodRequests() async {
    final resp = await http.get(Uri.parse('$_baseUrl/food-requests/all'));
    if (resp.statusCode != 200) throw Exception('Fetch failed [${resp.statusCode}]');
    final data = json.decode(resp.body) as List;
    return data.map((j) => FoodRequest.fromJson(j)).toList();
  }

  Future<FoodRequest> createFoodRequest(FoodRequest r) async {
    final resp = await http.post(
      Uri.parse('$_baseUrl/food-requests/create'),
      headers: {'Content-Type':'application/json'},
      body: json.encode(r.toJson()),
    );
    if (resp.statusCode != 200) throw Exception('Create failed [${resp.statusCode}]');
    return FoodRequest.fromJson(json.decode(resp.body));
  }

  Future<FoodRequest> updateFoodRequest(FoodRequest r) async {
    final resp = await http.put(
      Uri.parse('$_baseUrl/food-requests/${r.id}'),
      headers: {'Content-Type':'application/json'},
      body: json.encode(r.toJson(forUpdate: true)),
    );
    if (resp.statusCode != 200) throw Exception('Update failed [${resp.statusCode}]');
    return FoodRequest.fromJson(json.decode(resp.body));
  }
  // ─── CHATBOT (FAQ) ─────────────────────────────────────────────────

  Future<List<FAQItem>> fetchFAQs() async {
    final uri = Uri.parse('$_baseUrl/faqs/all');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final List<dynamic> data = json.decode(resp.body);
      return data.map((j) => FAQItem.fromJson(j)).toList();
    }
    throw Exception('Fetch FAQs failed [${resp.statusCode}]');
  }

  Future<String> askFAQ(String question) async {
    final uri = Uri.parse('$_baseUrl/faqs/ask');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'question': question}),
    );
    if (resp.statusCode == 200) {
      return json.decode(resp.body)['answer'] as String;
    }
    throw Exception('FAQ query failed [${resp.statusCode}]');
  }

  /// ─── ROOMMATE PREFERENCES ───────────────────────────────────────────

    // ─── ROOMMATE PREFERENCES ───────────────────────────────────────────

  /// Submits roommate preferences.
  Future<RoommatePref> submitPref(RoommatePref pref) async {
    final uri = Uri.parse('$_baseUrl/roommate/submit');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pref.toJson()),
    );
    if (resp.statusCode == 200) {
      return RoommatePref.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Submit preferences failed [${resp.statusCode}]: ${resp.body}');
    }
  }

  /// Retrieves the best roommate match for a student ID.
  Future<RoommatePref> getMatch(int studentId) async {
    final uri = Uri.parse('$_baseUrl/roommate/match/$studentId');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      return RoommatePref.fromJson(json.decode(resp.body));
    } else {
      throw Exception('Get match failed [${resp.statusCode}]: ${resp.body}');
    }
  }

}
