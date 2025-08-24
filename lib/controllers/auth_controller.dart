import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../views/otp_screen.dart';
import '../views/object_list_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ConfirmationResult _confirmationResult;

  // Send OTP
  Future<void> sendOTP(String phone) async {
    try {
      _confirmationResult = await _auth.signInWithPhoneNumber(phone);
      Get.to(() => OTPScreen()); // Navigate to OTP screen
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Verify OTP
  Future<void> verifyOTP(String otp) async {
    try {
      final UserCredential userCred = await _confirmationResult.confirm(otp);

      if (userCred.user != null) {
        Get.offAll(() => const ObjectListPage()); // Dashboard after login
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
