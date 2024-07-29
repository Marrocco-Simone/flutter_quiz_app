import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../styles/colors.dart';

class PracticeButton extends StatelessWidget {
  const PracticeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: topBarColor,
                padding: const EdgeInsets.all(20)),
            onPressed: () => context.go("/practice"),
            child: const Text("Practice",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ))));
  }
}
