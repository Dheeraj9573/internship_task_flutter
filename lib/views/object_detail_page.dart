// lib/views/object_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';

class ObjectDetailPage extends StatefulWidget {
  final ObjectModel object;
  const ObjectDetailPage({super.key, required this.object});

  @override
  State<ObjectDetailPage> createState() => _ObjectDetailPageState();
}

class _ObjectDetailPageState extends State<ObjectDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.object.name); // ✅ Updated
    _descController = TextEditingController(text: widget.object.description);
  }

  Future<void> _updateObject() async {
    setState(() => _loading = true);

    final updatedObject = ObjectModel(
      id: widget.object.id,
      name: _titleController.text.trim(), // ✅ Updated
      description: _descController.text.trim(),
    );

    await ObjectService.updateObject(updatedObject);

    setState(() => _loading = false);
    Get.back();
  }

  Future<void> _deleteObject() async {
    setState(() => _loading = true);
    await ObjectService.deleteObject(widget.object.id);
    setState(() => _loading = false);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📝 Object Details"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  onPressed: _loading ? null : _updateObject,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Update"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _loading ? null : _deleteObject,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Delete"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
