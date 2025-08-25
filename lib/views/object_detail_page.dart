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
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.object.name);
    _descriptionController = TextEditingController(
      text: widget.object.data?['description']?.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Object Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updated = ObjectModel(
                  id: widget.object.id ?? "",
                  name: _nameController.text,
                  data: {
                    "description": _descriptionController.text,
                  },
                );
                await ObjectService.updateObject(updated);
                Get.back(result: true);
              },
              child: const Text("Save Changes"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                if (widget.object.id != null) {
                  await ObjectService.deleteObject(widget.object.id!);
                  Get.back(result: true);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
