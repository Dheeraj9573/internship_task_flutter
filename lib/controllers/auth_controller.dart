import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = "".obs;

  // Send OTP
  Future<void> sendOTP(String phone, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.offAllNamed("/dashboard");
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("❌ ${e.message}")));
      },
      codeSent: (String verId, int? resendToken) {
        verificationId.value = verId;
        Get.toNamed("/otp");
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId.value = verId;
      },
    );
  }

  // Verify OTP
  Future<void> verifyOTP(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      Get.offAllNamed("/dashboard");
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed("/");
  }
}