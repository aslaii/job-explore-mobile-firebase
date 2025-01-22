# Task 3: Firebase Integration with Mobile App

## Overview
This documentation demonstrates the successful integration of Firebase services into a Flutter mobile application, implementing both Authentication and Cloud Firestore for a complete job posting platform.

## Demo & Setup
![Mobile App Demo](Mobile%20App%20Demo.gif)

Check out our Firebase Console configuration:
![Firebase Console Setup](Firebase%20Console.png)

## Implementation Details

### 1. Firebase Authentication Implementation

#### 1.1 Authentication Provider
```dart
// lib/services/auth_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isAuthenticated => _user != null;
}
```

#### 1.2 Authentication Service
```dart
// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
```

#### 1.3 Authentication Flow
1. Login Page (`lib/pages/auth/login/login_widget.dart`)
   - Email and password login
   - Error handling with user feedback
   - Navigation to registration
   - "Forgot Password" functionality

2. Registration Page (`lib/pages/auth/register/register_widget.dart`)
   - New user registration form
   - Password validation
   - Success/error handling
   - Navigation back to login

3. Authentication Flow Navigation
   - Initial auth check on app launch
   - Protected routes for authenticated users
   - Auto-redirect to login for unauthenticated users

### 2. Cloud Firestore Integration

#### 2.1 Job Service
```dart
// lib/services/job_service.dart
class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<JobModel>> getJobs() async {
    try {
      final querySnapshot = await _firestore
          .collection('jobs')
          .orderBy('datePosted', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => JobModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching jobs: $e');
      return [];
    }
  }

  Future<void> createJob(String jobName, String company) async {
    try {
      await _firestore.collection('jobs').add({
        'jobName': jobName,
        'company': company,
        'datePosted': Timestamp.now(),
      });
    } catch (e) {
      print('Error creating job: $e');
      rethrow;
    }
  }
}
```

## Project Configuration

### 1. Dependencies
```yaml
dependencies:
  firebase_core: ^3.10.1
  firebase_auth: ^5.4.1
  cloud_firestore: ^5.6.2
```

### 2. Project Structure
```
lib/
├── components/
│   └── headerlogo/
│       ├── headerlogo_model.dart
│       └── headerlogo_widget.dart
├── models/
│   └── job_model.dart
├── pages/
│   ├── auth/
│   ├── candidates/
│   ├── companies/
│
