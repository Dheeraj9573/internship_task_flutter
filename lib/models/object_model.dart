// lib/models/object_model.dart

class ObjectModel {
  final String id;        // keep as String for compatibility with API
  final String name;
  final String description;

  ObjectModel({
    required this.id,
    required this.name,
    required this.description,
  });

  // Convert JSON → ObjectModel
  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      id: json['id'].toString(), // force everything to String
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // Convert ObjectModel → JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }
}
