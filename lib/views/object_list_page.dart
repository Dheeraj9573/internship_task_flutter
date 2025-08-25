import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'add_object_page.dart';
import 'edit_object_page.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';
import 'dart:html'; // For HtmlElementView (reCAPTCHA)

class ObjectListPage extends StatefulWidget {
  const ObjectListPage({super.key});

  @override
  State<ObjectListPage> createState() => _ObjectListPageState();
}

class _ObjectListPageState extends State<ObjectListPage> {
  List<ObjectModel> objects = [];

  @override
  void initState() {
    super.initState();
    _fetchObjects();
  }

  Future<void> _fetchObjects() async {
    try {
      final data = await ObjectService.getObjects();
      setState(() => objects = data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> _deleteObject(String id) async {
    try {
      await ObjectService.deleteObject(id);
      _fetchObjects();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void _editObject(ObjectModel obj) {
    Get.to(() => EditObjectPage(object: obj))?.then((value) {
      _fetchObjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Objects Dashboard")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: objects.length,
              itemBuilder: (context, index) {
                final obj = objects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(obj.name),
                    subtitle: Text(obj.description), // ✅ use description
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editObject(obj),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteObject(obj.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 78,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 300,
                      height: 78,
                      child: HtmlElementView(viewType: 'recaptcha-container'),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () async {
                      final result = await Get.to(() => AddObjectPage());
                      if (result == true) _fetchObjects();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Object"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
