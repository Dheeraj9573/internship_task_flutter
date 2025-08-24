import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // ✅ Make sure this exists from your setup

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ Login anonymously just for seeding data
  UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  final uid = userCredential.user!.uid;

  final firestore = FirebaseFirestore.instance;

  // 📌 List of objects (programming + web dev tools)
  final objects = [
    {
      "title": "C",
      "description": "A powerful low-level language widely used for system programming, embedded systems, and OS development. Known for speed and efficiency.",
    },
    {
      "title": "C++",
      "description": "Extension of C with object-oriented features, used in game engines, high-performance apps, and real-time simulations.",
    },
    {
      "title": "Java",
      "description": "A platform-independent language widely used in enterprise applications, Android development, and backend systems.",
    },
    {
      "title": "Python",
      "description": "A high-level, easy-to-learn language with libraries for AI, ML, data science, and automation.",
    },
    {
      "title": "Go (Golang)",
      "description": "A modern, fast, and concurrent language developed by Google, excellent for scalable server-side apps.",
    },
    {
      "title": "MERN Stack",
      "description": "Combination of MongoDB, Express.js, React.js, and Node.js for full-stack JavaScript development.",
    },
    {
      "title": "Angular",
      "description": "A powerful TypeScript-based frontend framework for building large-scale web apps.",
    },
    {
      "title": "Flask",
      "description": "A lightweight Python web framework, perfect for building APIs and small-scale apps.",
    },
    {
      "title": "Rust",
      "description": "A memory-safe, high-performance language gaining popularity for web assembly and backend services.",
    },
    {
      "title": "Django",
      "description": "A full-featured Python web framework with built-in security, ORM, and admin dashboard.",
    },
  ];

  // ✅ Insert objects into Firestore
  for (var obj in objects) {
    await firestore.collection("objects").add({
      "title": obj["title"],
      "description": obj["description"],
      "uid": uid,
      "createdAt": FieldValue.serverTimestamp(),
    });
    print("✅ Added ${obj['title']}");
  }

  print("🎉 Seeding completed successfully!");
}
