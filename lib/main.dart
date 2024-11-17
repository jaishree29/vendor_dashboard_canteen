import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vendor_digital_canteen/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyDVbk65CSWprjL8CaFefZN6GWAXHqXO5ZM",
    appId: "1:842577050248:android:63819da5a5e7124099fd3d",
    messagingSenderId: "842577050248",
    projectId: "digital-canteen-be010",
  );

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(const MyApp());
}
