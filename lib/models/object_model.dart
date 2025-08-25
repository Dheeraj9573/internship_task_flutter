class ObjectModel {
  final String id;
  final String name;
  final String description;

  ObjectModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }
}
