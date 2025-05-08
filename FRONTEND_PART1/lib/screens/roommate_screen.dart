// lib/screens/roommate_screen.dart

import 'package:flutter/material.dart';

class RoommatePref {
  final int studentId;
  final String sleepSchedule;
  final String cleanliness;
  final String studyHabits;
  final String hobbies;
  final String dietary;
  final String sleepingPreference;

  RoommatePref({
    required this.studentId,
    required this.sleepSchedule,
    required this.cleanliness,
    required this.studyHabits,
    required this.hobbies,
    required this.dietary,
    required this.sleepingPreference,
  });
}

class RoommateScreen extends StatefulWidget {
  const RoommateScreen({Key? key}) : super(key: key);
  @override
  _RoommateScreenState createState() => _RoommateScreenState();
}

class _RoommateScreenState extends State<RoommateScreen> {
  final _formKey       = GlobalKey<FormState>();
  final _idCtl         = TextEditingController();
  final _sleepCtl      = TextEditingController();
  final _cleanCtl      = TextEditingController();
  final _studyCtl      = TextEditingController();
  final _hobbyCtl      = TextEditingController();
  final _dietCtl       = TextEditingController();
  final _sleepPrefCtl  = TextEditingController();

  final List<RoommatePref> _allPrefs = [];
  RoommatePref? _bestMatch;

  @override
  void dispose() {
    _idCtl.dispose();
    _sleepCtl.dispose();
    _cleanCtl.dispose();
    _studyCtl.dispose();
    _hobbyCtl.dispose();
    _dietCtl.dispose();
    _sleepPrefCtl.dispose();
    super.dispose();
  }

  void _submitPreferences() {
    if (!_formKey.currentState!.validate()) return;

    final sid = int.parse(_idCtl.text.trim());
    final me = RoommatePref(
      studentId:        sid,
      sleepSchedule:    _sleepCtl.text.trim(),
      cleanliness:      _cleanCtl.text.trim(),
      studyHabits:      _studyCtl.text.trim(),
      hobbies:          _hobbyCtl.text.trim(),
      dietary:          _dietCtl.text.trim(),
      sleepingPreference:_sleepPrefCtl.text.trim(),
    );

    setState(() {
      _allPrefs.removeWhere((p) => p.studentId == sid);
      _allPrefs.add(me);
      _bestMatch = null; // clear any previous match
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences submitted!')),
    );
  }

  void _findBestMatch() {
    final sid = int.tryParse(_idCtl.text.trim());
    if (sid == null) return;

    // find "me" by index
    final idx = _allPrefs.indexWhere((p) => p.studentId == sid);
    if (idx == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submit your preferences first.')),
      );
      return;
    }
    final me = _allPrefs[idx];

    if (_allPrefs.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Need at least two students to match.')),
      );
      return;
    }

    RoommatePref? best;
    var bestScore = -1;
    for (final other in _allPrefs) {
      if (other.studentId == sid) continue;
      var score = 0;
      if (me.sleepSchedule      == other.sleepSchedule)      score++;
      if (me.cleanliness        == other.cleanliness)        score++;
      if (me.studyHabits        == other.studyHabits)        score++;
      if (me.hobbies            == other.hobbies)            score++;
      if (me.dietary            == other.dietary)            score++;
      if (me.sleepingPreference == other.sleepingPreference) score++;
      if (score > bestScore) {
        bestScore = score;
        best = other;
      }
    }

    if (best == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No suitable match found.')),
      );
      return;
    }

    setState(() => _bestMatch = best);
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roommate Matching')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _idCtl,
                decoration: const InputDecoration(
                  labelText: 'Your Student ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _sleepCtl,
                decoration: const InputDecoration(
                  labelText: 'Sleep Schedule',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cleanCtl,
                decoration: const InputDecoration(
                  labelText: 'Cleanliness',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _studyCtl,
                decoration: const InputDecoration(
                  labelText: 'Study Habits',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _hobbyCtl,
                decoration: const InputDecoration(
                  labelText: 'Hobbies',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _dietCtl,
                decoration: const InputDecoration(
                  labelText: 'Dietary',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _sleepPrefCtl,
                decoration: const InputDecoration(
                  labelText: 'Sleeping Preference',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitPreferences,
                    child: const Text('Submit Preferences'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _findBestMatch,
                    child: const Text('Get Best Match'),
                  ),
                ),
              ]),
            ]),
          ),

          // Show Your Own Pref
          const SizedBox(height: 24),
          if (_allPrefs.isNotEmpty &&
              int.tryParse(_idCtl.text.trim()) != null)
            ...[
              const Text('Your Preferences:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Builder(builder: (_) {
                final sid = int.parse(_idCtl.text.trim());
                final idx = _allPrefs.indexWhere((p) => p.studentId == sid);
                if (idx == -1) return const SizedBox.shrink();
                final me = _allPrefs[idx];
                return _buildCard(me);
              }),
            ],

          // Show Best Match
          if (_bestMatch != null) ...[
            const Divider(height: 32),
            Text('Best Match (Student ${_bestMatch!.studentId}):',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            _buildCard(_bestMatch!),
          ],
        ]),
      ),
    );
  }

  Widget _buildCard(RoommatePref p) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Sleep Schedule: ${p.sleepSchedule}'),
          Text('Cleanliness:     ${p.cleanliness}'),
          Text('Study Habits:    ${p.studyHabits}'),
          Text('Hobbies:         ${p.hobbies}'),
          Text('Dietary:         ${p.dietary}'),
          Text('Sleeping Pref:   ${p.sleepingPreference}'),
        ]),
      ),
    );
  }
}
