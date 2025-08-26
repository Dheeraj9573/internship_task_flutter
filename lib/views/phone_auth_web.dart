import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'object_list_page.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  String? _verificationId;
  bool _isOtpSent = false;
  bool _loading = false;

  /// Send OTP
  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty || !phone.startsWith("+")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠ Enter phone in format +91XXXXXXXXXX")),
      );
      return;
    }

    setState(() => _loading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offAll(() => const ObjectListPage());
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠ Verification failed: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isOtpSent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("📩 OTP sent successfully")),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );

    setState(() => _loading = false);
  }

  /// Verify OTP
  Future<void> _verifyOtp() async {
    if (_verificationId == null) return;

    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠ Enter OTP")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(() => const ObjectListPage());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Login successful")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Invalid OTP: $e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📱 Phone Login"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(Icons.lock_outline, size: 100, color: Colors.blueAccent.shade100),
            const SizedBox(height: 30),
            Text(
              _isOtpSent ? "Enter the OTP sent to your phone" : "Enter your phone number",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            if (!_isOtpSent)
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "+91XXXXXXXXXX",
                  border: OutlineInputBorder(),
                ),
              ),

            if (_isOtpSent)
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "OTP",
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _loading ? null : (_isOtpSent ? _verifyOtp : _sendOtp),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
              ),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(_isOtpSent ? "Verify OTP" : "Send OTP"),
            )
          ],
        ),
      ),
    );
  }
}