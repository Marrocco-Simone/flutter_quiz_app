import 'package:flutter/material.dart';

class CorrectAnswersText extends StatelessWidget {
  final int correctAswers;
  const CorrectAnswersText(this.correctAswers, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: Text("Total correct answers: $correctAswers",
            style: const TextStyle(
              fontSize: 40,
              color: Colors.black,
            )));
  }
}
