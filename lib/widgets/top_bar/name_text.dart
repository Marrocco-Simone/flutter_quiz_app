import 'package:flutter/material.dart';

class NameText extends StatelessWidget {
  const NameText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Quiz App!",
      style: TextStyle(
          fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
