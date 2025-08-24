import 'dart:ui_web' as ui; // ✅ Needed for Flutter Web
import 'dart:html';          // For DivElement

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class PhoneAuthPage extends StatelessWidget {
  final phoneController = TextEditingController();
  final AuthController authC = Get.find();

  PhoneAuthPage({super.key}) {
    // Register reCAPTCHA container for Web
    ui.platformViewRegistry.registerViewFactory(
      'recaptcha-container',
      (int viewId) => DivElement()..id = 'recaptcha-container',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📱 Phone Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Icon(Icons.phone_android, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 30),
            const Text("Enter your phone number (e.g. +91XXXXXXXXXX)",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "+91XXXXXXXXXX",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // reCAPTCHA placeholder
            SizedBox(
              height: 80,
              child: HtmlElementView(viewType: 'recaptcha-container'),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final phone = phoneController.text.trim();
                  if (phone.isNotEmpty) {
                    authC.sendOTP(phone);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("⚠ Enter a valid phone")),
                    );
                  }
                },
                child: const Text("Send OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}