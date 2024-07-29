import 'package:flutter/material.dart';

class NoTopicsText extends StatelessWidget {
  const NoTopicsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(40),
        child: const Text("No topics available",
            style: TextStyle(
              fontSize: 50,
              color: Colors.black,
            )));
  }
}
