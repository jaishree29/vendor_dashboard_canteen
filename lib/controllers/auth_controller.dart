import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vendor_digital_canteen/models/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }

  // Sign out from Google
  Future<void> signOutFromGoogle() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  // Sign In with email and password
  Future<UserModel?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          UserModel userModel = UserModel.fromFirestore(userDoc);
          if (userModel.role == 'vendor') {
            return userModel;
          } else {
            await _auth.signOut();
            throw Exception('Only vendors can sign in.');
          }
        } else {
          await _auth.signOut();
          throw Exception('User not found.');
        }
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
    return null;
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          UserModel userModel = UserModel.fromFirestore(userDoc);
          if (userModel.role == 'vendor') {
            return userModel;
          } else {
            await _auth.signOut();
            throw Exception('Only vendors can sign in.');
          }
        } else {
          await _auth.signOut();
          throw Exception('User not found.');
        }
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
    return null;
  }
}
