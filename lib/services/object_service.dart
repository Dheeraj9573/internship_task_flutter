import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/object_model.dart';

class ObjectService {
  // ✅ Use 127.0.0.1 instead of localhost to avoid https redirect
  static const String baseUrl = "https://internship-task-flutter-paxm1b1m0-dheerajs-projects-d0e22280.vercel.ap";

  static Future<List<ObjectModel>> getObjects() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ObjectModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch objects: ${response.statusCode}");
    }
  }

  static Future<void> addObject(ObjectModel object) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": object.id,
        "name": object.name,
        "description": object.description,
      }),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Failed to add object: ${response.statusCode}");
    }
  }

  static Future<void> updateObject(ObjectModel object) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${object.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": object.id,
        "name": object.name,
        "description": object.description,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update object: ${response.statusCode}");
    }
  }

  static Future<void> deleteObject(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete object: ${response.statusCode}");
    }
  }
}
