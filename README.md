# 📚 Programming & Tools Dashboard

A Flutter project developed as part of my **Frontend Development Internship Assignment**.  
This app demonstrates **CRUD operations** (Create, Read, Update, Delete) using a REST API powered by **json-server**.

---

## 👤 Author
**Name:** Thuppudu Dheeraj Kumar  
**College:** VNR Vignana Jyothi Institute of Engineering and Technology  
**GitHub:** [Dheeraj9573](https://github.com/Dheeraj9573/internship_task_flutter)  

---

## 🌐 Web App
You can access the live web version of the app here:  
[Programming & Tools Dashboard Web App](https://internship-task-flutter.vercel.app/)

---

## 📱 Android APK
Download and install the Android app directly from this mobile-friendly link:  
[Download APK](https://www.dropbox.com/scl/fi/5fqrvhxbhldaij9205129/app-release.apk?rlkey=fris47uy96dkfi197smczg0r2&st=452n4ud9&dl=1)

---

## ✨ Features
- 🔹 View a list of programming languages and web development tools  
- 🔹 Add new objects with title and description  
- 🔹 Edit existing objects  
- 🔹 Delete objects from the dashboard  
- 🔹 Firebase Phone Authentication (web + mobile)  
- 🔹 Backend served by `json-server` (fake REST API)  
- 🔹 Frontend built with **Flutter (Web + Mobile support)**  

---

## 🛠️ Tech Stack
- **Frontend:** Flutter (Dart, Material UI, GetX for state management)  
- **Backend:** json-server (REST API, running locally)  
- **Database:** db.json (mock data file)  
- **Authentication:** Firebase Phone Auth (web & mobile)

---

## ⚙️ Firebase Phone Auth Setup

1. **Firebase Project**  
   1. Go to [Firebase Console](https://console.firebase.google.com/).  
   2. Create a new project (or use an existing one).  

2. **Add Platforms**  
   - **Web:** Register your web app, copy the Firebase config, and add it to `web/index.html`.  
   - **Android:** Register Android app, download `google-services.json`, and place it in `android/app/`.  

3. **Enable Phone Authentication**  
   - Go to **Authentication → Sign-in method → Phone** and enable it.  
   - Configure test phone numbers (optional for development).  

---

## 📲 Test Credentials (for development)

To test Firebase Phone Authentication without real OTP SMS:  

- **Phone Number:** `+919573021178`  
- **OTP Code:** `123456`  

👉 Enter the phone number on the login screen, then enter the test OTP to access the dashboard.  

---


## 🖼️ Screenshots

### 1️⃣ Data Model
![Data Model](assets/Screenshot%202025-08-24%20232055.png)  
*Data Model implemented in Dart matching the API response with `fromJson` and `toJson`.*

### 2️⃣ Enter Phone Number
![Enter Phone Number](assets/Screenshot%202025-08-24%20192323.png)  
*Screen for entering a phone number for authentication or verification.*

### 3️⃣ Enter OTP
![Enter OTP](assets/Screenshot%202025-08-24%20192418.png)  
*Screen for entering the OTP during authentication or verification.*

### 4️⃣ Dashboard
![Dashboard](assets/Screenshot%202025-08-24%20192452.png)  
*Dashboard view showing all objects and their details.*

### 5️⃣ Add Object
![Add Object](assets/Screenshot%202025-08-24%20192523.png)  
*Form to add a new object to the dashboard.*

### 6️⃣ Update Object
![Update Object](assets/Screenshot%202025-08-24%20192117.png)  
*Editing/updating an existing object with pre-filled details.*

### 7️⃣ Delete Object
![Delete Object](assets/Screenshot%202025-08-24%20192117.png)  
*Confirmation popup when deleting an object.*


## 📦 Dependencies (`pubspec.yaml`)
```yaml
name: internship_task
description: A Flutter project for internship assignment
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^4.0.0
  firebase_auth: ^6.0.1
  cloud_firestore: ^6.0.0

  # HTTP client for REST API
  http: ^1.2.2

  # State management
  get: ^4.6.6

  # Country phone input field
  intl_phone_field: ^3.2.0

  # Icons & material design
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true

  assets:
    - assets/

---

🗂️ Code Structure & Design

lib/
├─ main.dart             # App entry point
├─ controllers/
│  ├─ auth_controller.dart    # Firebase Phone Auth logic
│  ├─ object_controller.dart  # CRUD operations & state management
├─ models/
│  ├─ object_model.dart      # Dart model for JSON data
├─ services/
│  ├─ object_service.dart    # API calls (GET, POST, PUT, DELETE)
├─ views/
│  ├─ auth/
│  │  ├─ phone_input_page.dart
│  │  └─ otp_verification_page.dart
│  ├─ dashboard/
│  │  ├─ object_list_page.dart
│  │  ├─ add_object_page.dart
│  │  └─ edit_object_page.dart
└─ utils/
   └─ validators.dart        # Input validation (JSON & form checks)

---