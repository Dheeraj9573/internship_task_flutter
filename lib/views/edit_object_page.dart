import 'package:flutter/material.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';
import 'package:get/get.dart';

class EditObjectPage extends StatelessWidget {
  final ObjectModel object;
  final TextEditingController _nameController;
  final TextEditingController _descController;

  EditObjectPage({super.key, required this.object})
      : _nameController = TextEditingController(text: object.name),
        _descController = TextEditingController(text: object.description);

  void _updateObject(BuildContext context) async {
    if (_nameController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter all fields");
      return;
    }

    final updatedObj = ObjectModel(
      id: object.id,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
    );

    try {
      await ObjectService.updateObject(updatedObj);
      Navigator.pop(context, true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Object")),
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
              onPressed: () => _updateObject(context),
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}