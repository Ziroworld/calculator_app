import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text; // Button text
  final VoidCallback onTap; // Callback for button press
  final Color backgroundColor; // Background color for the button
  final Color textColor; // Text color for the button

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
