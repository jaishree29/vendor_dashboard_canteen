import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_digital_canteen/controllers/auth_controller.dart';
import 'package:vendor_digital_canteen/navigation_page.dart';
import 'package:vendor_digital_canteen/splash_screen.dart';
import 'package:vendor_digital_canteen/utils/constants/colors.dart';
import 'package:vendor_digital_canteen/widgets/elevated_button.dart';
import 'package:vendor_digital_canteen/widgets/text_field_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  // Sign-In with Email and Password
  void _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    try {
      // Sign in the user with email and password
      final user =
          await _authController.signInWithEmailPassword(email, password);

      if (!mounted) return;

      // If sign-in is successful
      if (user != null) {
        // Store login state in SharedPreferences
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome back, ${user.email}!")),
        );

        // Navigate to the next page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPage()),
        );
      } else {
        // If the user is not found, prompt them to sign up
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Only vendors can sign in!")),
        );
      }
    } catch (e) {
      // Handle any errors during sign-in (like wrong credentials)
      print("Sign-in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.mail, size: 70),
                const SizedBox(height: 80),

                // Email TextField
                NTextFieldInput(
                  hintText: 'Email',
                  icon: Icons.email,
                  isPass: false,
                  textController: _emailController,
                ),

                // Password TextField
                NTextFieldInput(
                  hintText: 'Password',
                  icon: Icons.lock,
                  isPass: true,
                  textController: _passwordController,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Column(
              children: [
                // Sign-In Button
                NElevatedButton(
                  text: 'Sign In',
                  onPressed: _handleSignIn,
                  backgroundColor: NColors.primary,
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}
