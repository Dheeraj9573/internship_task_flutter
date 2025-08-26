import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'otp_screen.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  bool loading = false;

  Future<void> _verifyPhone() async {
    String phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      Get.snackbar("Error", "Enter phone number");
      return;
    }

    setState(() => loading = true);

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.offAllNamed("/dashboard");
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => loading = false);
        Get.snackbar("Error", e.message ?? "Verification failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() => loading = false);
        Get.to(() => OtpScreen(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phone Auth")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number (+91xxxxxxxxxx)",
              ),
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verifyPhone,
                    child: const Text("Verify"),
                  ),
            const SizedBox(height: 20),
            // ✅ reCAPTCHA attaches here automatically
            const SizedBox(height: 20),
            const Text("reCAPTCHA will appear below:"),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: Center(
                child: HtmlElementView(
                  viewType: 'recaptcha-container',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}