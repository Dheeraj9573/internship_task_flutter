import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final AuthController authC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login with OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              if (!authC.isOtpSent.value) ...[
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone Number (+91xxxxxxxxxx)",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String phone = phoneController.text.trim();
                    if (phone.isNotEmpty) {
                      authC.sendOtp(phone);
                    }
                  },
                  child: const Text("Send OTP"),
                ),
              ] else ...[
                TextField(
                  controller: otpController,
                  decoration: const InputDecoration(labelText: "Enter OTP"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String otp = otpController.text.trim();
                    if (otp.isNotEmpty) {
                      authC.verifyOtp(otp);
                    }
                  },
                  child: const Text("Verify OTP"),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}