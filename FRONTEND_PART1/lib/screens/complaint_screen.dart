// lib/screens/complaint_screen.dart

import 'package:flutter/material.dart';
import '../models/complaint.dart';
import '../models/session.dart';
import '../services/api_service.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});
  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final ApiService _api = ApiService();
  late Future<List<Complaint>> _futureComplaints;

  final _formKey     = GlobalKey<FormState>();
  final _studentCtl  = TextEditingController();
  final _categoryCtl = TextEditingController();
  final _descCtl     = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  void _loadComplaints() {
    setState(() {
      _futureComplaints = _api.fetchComplaints();
    });
  }

  @override
  void dispose() {
    _studentCtl.dispose();
    _categoryCtl.dispose();
    _descCtl.dispose();
    super.dispose();
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;
    final newC = Complaint(
      id:          0,
      studentId:   _studentCtl.text.trim(),
      category:    _categoryCtl.text.trim(),
      description: _descCtl.text.trim(),
      status:      'Pending',
    );
    try {
      await _api.createComplaint(newC);
      _studentCtl.clear();
      _categoryCtl.clear();
      _descCtl.clear();
      _loadComplaints();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _updateStatus(Complaint c, String newStatus) async {
    final updated = Complaint(
      id:          c.id,
      studentId:   c.studentId,
      category:    c.category,
      description: c.description,
      status:      newStatus,
    );
    try {
      await _api.createComplaint(updated);
      _loadComplaints();
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Status set to $newStatus')));
    } catch (e) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Update failed: $e')));
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final isStaff = 
      Session.role == 'Admin' ||
      Session.role == 'Warden' ||
      Session.role == 'Maintenance';

    return Scaffold(
      appBar: AppBar(title: const Text('File a Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // ─── Input Form ─────────────────────────────
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _studentCtl,
                decoration: const InputDecoration(
                  labelText: 'Student ID', border: OutlineInputBorder()),
                validator: (v) =>
                  v == null || v.isEmpty ? 'Student ID required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _categoryCtl,
                decoration: const InputDecoration(
                  labelText: 'Category', border: OutlineInputBorder()),
                validator: (v) =>
                  v == null || v.isEmpty ? 'Category required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtl,
                decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
                validator: (v) =>
                  v == null || v.isEmpty ? 'Description required' : null,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitComplaint,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Submit Complaint'),
                  ),
                ),
              ),
            ]),
          ),

          const SizedBox(height: 16),

          // ─── Complaints List ───────────────────────
          Expanded(
            child: FutureBuilder<List<Complaint>>(
              future: _futureComplaints,
              builder: (ctx, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Error: ${snap.error}'));
                }

                // sort newest first
                final list = snap.data!..sort((a, b) => b.id.compareTo(a.id));
                if (list.isEmpty) {
                  return const Center(child: Text('No complaints filed yet.'));
                }

                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) {
                    final cm = list[i];
                    return ListTile(
                      title: Text(cm.category),
                      subtitle: Text(
                        'Student ID: ${cm.studentId}\n'
                        'Description: ${cm.description}\n'
                        'Status: ${cm.status}',
                      ),
                      isThreeLine: true,
                      trailing: isStaff
                        ? Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.green),
                              onPressed: () => _updateStatus(cm, 'Accepted'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => _updateStatus(cm, 'Rejected'),
                            ),
                          ])
                        : null,
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
