import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text("✅ Logged in successfully!"),
      ),
    );
  }
}