// lib/screens/food_request_screen.dart

import 'package:flutter/material.dart';
import '../models/food_request.dart';
import '../models/session.dart';
import '../services/api_service.dart';

class FoodRequestScreen extends StatefulWidget {
  const FoodRequestScreen({Key? key}) : super(key: key);
  @override
  State<FoodRequestScreen> createState() => _FoodRequestScreenState();
}

class _FoodRequestScreenState extends State<FoodRequestScreen> {
  final ApiService _api = ApiService();
  late Future<List<FoodRequest>> _futureRequests;

  final _formKey    = GlobalKey<FormState>();
  final _studentCtl = TextEditingController();
  final _roomCtl    = TextEditingController();
  final _foodCtl    = TextEditingController();
  final _specCtl    = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  @override
  void dispose() {
    _studentCtl.dispose();
    _roomCtl.dispose();
    _foodCtl.dispose();
    _specCtl.dispose();
    super.dispose();
  }

  void _loadRequests() {
    _futureRequests = _api.fetchFoodRequests();
    setState(() {});
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final req = FoodRequest(
      id:             0,
      studentId:      _studentCtl.text.trim(),
      roomNumber:     _roomCtl.text.trim(),
      foodType:       _foodCtl.text.trim(),
      specialRequest: _specCtl.text.trim(),
      status:         'Pending',
    );

    try {
      await _api.createFoodRequest(req);
      _studentCtl.clear();
      _roomCtl.clear();
      _foodCtl.clear();
      _specCtl.clear();
      _loadRequests();
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Request submitted!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _updateStatus(FoodRequest fr, String status) async {
    try {
      final updated = fr.copyWith(status: status);
      await _api.updateFoodRequest(updated);
      _loadRequests();
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Status set to $status')));
    } catch (e) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Update failed: $e')));
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Requests')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // ─── Request Form ────────────────────────────
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _studentCtl,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _roomCtl,
                decoration: const InputDecoration(
                  labelText: 'Room Number',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _foodCtl,
                decoration: const InputDecoration(
                  labelText: 'Food Type',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _specCtl,
                decoration: const InputDecoration(
                  labelText: 'Special Request',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Submit Request'),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          // ─── All Requests List ───────────────────────
          Expanded(
            child: FutureBuilder<List<FoodRequest>>(
              future: _futureRequests,
              builder: (ctx, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Error: ${snap.error}'));
                }
                final data = snap.data!;
                final list = List<FoodRequest>.from(data);
                list.sort((a, b) => b.id.compareTo(a.id));

                if (list.isEmpty) {
                  return const Center(child: Text('No requests yet.'));
                }
                return RefreshIndicator(
                  onRefresh: () async => _loadRequests(),
                  child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, i) {
                      final fr = list[i];
                      return ListTile(
                        title: Text(fr.foodType),
                        subtitle: Text(
                          'Student: ${fr.studentId}\n'
                          'Room: ${fr.roomNumber}\n'
                          'Status: ${fr.status}',
                        ),
                        isThreeLine: true,
                        trailing: (Session.role == 'Admin' ||
                                   Session.role == 'Warden')
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.check, color: Colors.green),
                                    onPressed: () => _updateStatus(fr, 'Approved'),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, color: Colors.red),
                                    onPressed: () => _updateStatus(fr, 'Rejected'),
                                  ),
                                ],
                              )
                            : null,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
