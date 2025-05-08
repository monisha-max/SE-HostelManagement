import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/lost_item_model.dart';
import '../services/lost_item_service.dart';

class LostAndFoundPage extends StatefulWidget {
  @override
  _LostAndFoundPageState createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  final LostItemService _service = LostItemService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Uint8List? pickedImageBytes;
  String? pickedFileName;

  List<LostItem> lostItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final items = await _service.fetchLostItems();
      setState(() {
        lostItems = items;
      });
    } catch (e) {
      print('Failed to load items: $e');
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        pickedImageBytes = result.files.single.bytes!;
        pickedFileName = result.files.single.name;
      });
    }
  }

  Future<void> _uploadItem() async {
    final title = titleController.text.trim();
    final desc = descController.text.trim();
    final location = locationController.text.trim();

    if (title.isEmpty || desc.isEmpty || location.isEmpty || pickedImageBytes == null || pickedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields and pick an image')));
      return;
    }

    final success = await _service.uploadLostItem(
      title: title,
      description: desc,
      location: location,
      imageBytes: pickedImageBytes!,
      fileName: pickedFileName!,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Uploaded successfully')));
      titleController.clear();
      descController.clear();
      locationController.clear();
      setState(() {
        pickedImageBytes = null;
        pickedFileName = null;
      });
      _loadItems();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed')));
    }
  }

  Future<void> _deleteItem(int id) async {
    final success = await _service.deleteItem(id);
    if (success) _loadItems();
  }

  Future<void> _resolveItem(int id) async {
    final success = await _service.resolveItem(id);
    if (success) _loadItems();
  }

  Widget _buildItemCard(LostItem item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(_service.getImageUrl(item.imagePath), width: 60, height: 60, fit: BoxFit.cover),
        title: Text(item.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${item.description}'),
            Text('Location: ${item.location}'),
            Text('Resolved: ${item.resolved ? "Yes" : "No"}'),
          ],
        ),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: item.resolved ? null : () => _resolveItem(item.id),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteItem(item.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextField(controller: titleController, decoration: InputDecoration(labelText: 'Item Name')),
        TextField(controller: descController, decoration: InputDecoration(labelText: 'Description')),
        TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location')),
        SizedBox(height: 10),
        ElevatedButton.icon(onPressed: _pickImage, icon: Icon(Icons.image), label: Text('Pick Image')),
        if (pickedImageBytes != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.memory(pickedImageBytes!, width: 100, height: 100),
          ),
        ElevatedButton(onPressed: _uploadItem, child: Text('Upload Lost Item')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lost & Found')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildForm(),
            Divider(height: 30),
            Text('Lost Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...lostItems.map(_buildItemCard).toList(),
          ],
        ),
      ),
    );
  }
}
