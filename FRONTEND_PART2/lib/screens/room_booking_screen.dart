import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/room_booking.dart';
import '../services/room_booking_service.dart';

class RoomBookingScreen extends StatefulWidget {
  const RoomBookingScreen({super.key});

  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  final _nameController = TextEditingController();
  final _roomController = TextEditingController();
  final _service = RoomBookingService();

  DateTime selectedDate = DateTime.now();
  List<RoomBooking> slots = [];
  final slotTimes = List.generate(8, (i) => '${8 + i}:00 - ${9 + i}:00');

  @override
  void initState() {
    super.initState();
    fetchBookingsForDate();
  }

  Future<void> fetchBookingsForDate() async {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    try {
      final all = await _service.fetchBookings(dateStr);
      setState(() {
        slots = slotTimes.map((t) {
          final matched = all.firstWhere(
              (b) => b.timeSlot == t,
              orElse: () => RoomBooking(timeSlot: t));
          return matched;
        }).toList();
      });
    } catch (_) {
      setState(() => slots = slotTimes.map((t) => RoomBooking(timeSlot: t)).toList());
    }
  }

  void pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      fetchBookingsForDate();
    }
  }

  Future<void> bookSlot(int index) async {
    final name = _nameController.text.trim();
    final room = _roomController.text.trim();
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    if (name.isEmpty || room.isEmpty) return;

    final message = await _service.bookSlot(
      username: name,
      roomNumber: room,
      timeSlot: slotTimes[index],
      date: dateStr,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    fetchBookingsForDate();
    _nameController.clear();
    _roomController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Cleaning Booking'), actions: [
        IconButton(icon: const Icon(Icons.calendar_month), onPressed: pickDate)
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Your Name')),
          TextField(
            controller: _roomController,
            decoration: const InputDecoration(labelText: 'Room Number'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: slots.length,
              itemBuilder: (context, index) {
                final slot = slots[index];
                return Card(
                  child: ListTile(
                    title: Text(slot.timeSlot),
                    subtitle: Text(slot.bookedBy ?? 'Available'),
                    trailing: ElevatedButton(
                      onPressed: slot.bookedBy == null ? () => bookSlot(index) : null,
                      child: const Text('Book'),
                    ),
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
