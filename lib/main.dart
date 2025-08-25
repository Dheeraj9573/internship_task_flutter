import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

// Import your pages
import 'views/phone_auth_page.dart';
import 'views/object_list_page.dart';  // ✅ Correct import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb ? DefaultFirebaseOptions.web : null,
  );

  Get.put(AuthController()); // Inject controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Internship Task',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => PhoneAuthPage()),
        GetPage(name: "/dashboard", page: () => ObjectListPage()), // ✅ fixed
      ],
    );
  }
}
