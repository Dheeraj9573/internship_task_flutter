// lib/services/object_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/object_model.dart';

class ObjectService {
  static const String baseUrl = "http://localhost:3000/objects";

  /// Fetch all objects
  static Future<List<ObjectModel>> getObjects() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ObjectModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load objects");
    }
  }

  /// Add new object
  static Future<void> addObject(ObjectModel object) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(object.toJson()),
    );
  }

  /// Update object
  static Future<void> updateObject(ObjectModel object) async {
    await http.put(
      Uri.parse("$baseUrl/${object.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(object.toJson()),
    );
  }

  /// Delete object
  static Future<void> deleteObject(String id) async {
    await http.delete(Uri.parse("$baseUrl/$id"));
  }
}
