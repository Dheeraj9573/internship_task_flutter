import 'package:get/get.dart';
import '../models/object_model.dart';
import '../services/object_service.dart';

class ObjectController extends GetxController {
  final ObjectService _service = ObjectService();

  var objects = <ObjectModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchObjects();
  }

  /// Fetch all objects
  Future<void> fetchObjects() async {
    try {
      isLoading(true);
      objects.value = await _service.fetchObjects();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Add object
  Future<void> addObject(ObjectModel obj) async {
    try {
      isLoading(true);
      final newObj = await _service.createObject(obj);
      objects.add(newObj);
      Get.snackbar("Success", "Object added successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Update object
  Future<void> updateObject(String id, ObjectModel obj) async {
    try {
      isLoading(true);
      final updated = await _service.updateObject(id, obj);
      int index = objects.indexWhere((o) => o.id == id);
      if (index != -1) {
        objects[index] = updated;
      }
      Get.snackbar("Success", "Object updated successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Delete object
  Future<void> deleteObject(String id) async {
    try {
      isLoading(true);
      await _service.deleteObject(id);
      objects.removeWhere((o) => o.id == id);
      Get.snackbar("Deleted", "Object removed successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
