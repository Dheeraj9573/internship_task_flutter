import 'package:flutter/material.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';
import 'package:get/get.dart';

class AddObjectPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _saveObject(BuildContext context) async {
    if (_nameController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter all fields");
      return;
    }

    final newObj = ObjectModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
    );

    try {
      await ObjectService.addObject(newObj);
      Navigator.pop(context, true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Object")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveObject(context),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}