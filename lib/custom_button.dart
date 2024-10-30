import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final IconData? icon; // Made icon nullable
  final String text;
  final Color color;
  final Color textColor;
  final Color borderColor; // New parameter for border color
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    this.icon, // Optional icon
    required this.text,
    required this.color,
    required this.textColor,
    required this.borderColor, // Required border color
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
            side: BorderSide(color: borderColor, width: 0.80), // Custom border color
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) // Show icon only if it's provided
              Icon(icon, color: textColor),
            if (icon != null) SizedBox(width: 8), // Space between icon and text
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
