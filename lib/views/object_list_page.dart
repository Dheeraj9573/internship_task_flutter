// lib/views/object_list_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';
import 'add_object_page.dart';
import 'object_detail_page.dart';

class ObjectListPage extends StatefulWidget {
  const ObjectListPage({super.key});

  @override
  State<ObjectListPage> createState() => _ObjectListPageState();
}

class _ObjectListPageState extends State<ObjectListPage> {
  late Future<List<ObjectModel>> _futureObjects;

  @override
  void initState() {
    super.initState();
    _futureObjects = ObjectService.getObjects();
  }

  void _refresh() {
    setState(() {
      _futureObjects = ObjectService.getObjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📚 Programming & Tools Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<ObjectModel>>(
        future: _futureObjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("❌ Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("📭 No objects found"));
          }

          final objects = snapshot.data!;

          return ListView.builder(
            itemCount: objects.length,
            itemBuilder: (context, index) {
              final obj = objects[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(obj.name), // ✅ Updated
                  subtitle: Text(obj.description),
                  onTap: () => Get.to(() => ObjectDetailPage(object: obj))!
                      .then((_) => _refresh()),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () =>
            Get.to(() => const AddObjectPage())!.then((_) => _refresh()),
      ),
    );
  }
}
