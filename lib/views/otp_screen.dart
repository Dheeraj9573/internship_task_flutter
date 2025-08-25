import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'object_list_page.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController otpController = TextEditingController();
  bool loading = false;

  Future<void> _verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      Get.snackbar("Error", "Enter OTP");
      return;
    }

    setState(() => loading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      // ✅ Redirect to dashboard after success
      Get.offAll(() => ObjectListPage());
    } catch (e) {
      setState(() => loading = false);
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "OTP",
                hintText: "Enter 6-digit code",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : _verifyOtp,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
