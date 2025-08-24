// lib/views/add_object_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';

class AddObjectPage extends StatefulWidget {
  const AddObjectPage({super.key});

  @override
  State<AddObjectPage> createState() => _AddObjectPageState();
}

class _AddObjectPageState extends State<AddObjectPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _loading = false;

  Future<void> _saveObject() async {
    if (_titleController.text.isEmpty || _descController.text.isEmpty) return;

    setState(() => _loading = true);

    final newObject = ObjectModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _titleController.text.trim(), // ✅ Updated
      description: _descController.text.trim(),
    );

    await ObjectService.addObject(newObject);

    setState(() => _loading = false);
    Get.back(); // go back to list page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("➕ Add Object"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Object Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              ),
              onPressed: _loading ? null : _saveObject,
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Save Object"),
            ),
          ],
        ),
      ),
    );
  }
}
