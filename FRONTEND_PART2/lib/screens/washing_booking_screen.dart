import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../models/washing_slot.dart';
import '../services/washing_service.dart';

class WashingBookingScreen extends StatefulWidget {
  final String jsessionId;

  const WashingBookingScreen({super.key, required this.jsessionId});

  @override
  State<WashingBookingScreen> createState() => _WashingBookingScreenState();
}

class _WashingBookingScreenState extends State<WashingBookingScreen> {
  final WashingService service = WashingService();
  final TextEditingController roomController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  List<WashingSlot> slots = [];

  @override
  void initState() {
    super.initState();
    loadSlots();
  }

  void loadSlots() async {
    setState(() => isLoading = true);
    try {
      slots = await service.fetchCalendar(selectedDate);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error loading slots');
    }
    setState(() => isLoading = false);
  }

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      loadSlots();
    }
  }

  void bookSlot(WashingSlot slot) async {
    final room = roomController.text.trim();
    if (room.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter your room number');
      return;
    }

    final result = await service.bookSlot(
      timeSlot: slot.timeSlot,
      roomNumber: room,
      date: selectedDate,
      jsessionId: widget.jsessionId,
    );

    Fluttertoast.showToast(msg: result);
    roomController.clear();
    loadSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Washing Machine Booking'),
        actions: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: pickDate),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: roomController,
              decoration: InputDecoration(labelText: 'Room Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    final slot = slots[index];
                    return Card(
                      child: ListTile(
                        title: Text(slot.timeSlot),
                        subtitle: Text(slot.bookedBy ?? 'Available'),
                        trailing: slot.bookedBy == null
                            ? ElevatedButton(
                                onPressed: () => bookSlot(slot),
                                child: Text('Book'),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
