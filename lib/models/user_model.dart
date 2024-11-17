import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String role; // Add role field

  UserModel({required this.uid, required this.email, required this.role});

  factory UserModel.fromFirebase(User? user) {
    return UserModel(
      uid: user!.uid,
      email: user.email!,
      role: 'vendor', // Default role, you can set this based on your logic
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      role: data['role'],
    );
  }
}
