import 'package:get/get.dart';
import '../views/otp_screen.dart';
import '../views/object_list_page.dart';

class AuthController extends GetxController {
  void sendOTP(String phone) {
    // Your OTP logic here
    print("Sending OTP to $phone");
    // Navigate after OTP success
    // Get.to(() => OTPScreen()); // optional
  }
}

class ObjectController extends GetxController {
  // Your object logic here
}
