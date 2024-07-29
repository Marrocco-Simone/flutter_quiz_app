import 'package:flutter/material.dart';

class CorrectAnswersTopicText extends StatelessWidget {
  final String name;
  final int correctCount;
  const CorrectAnswersTopicText(this.name, this.correctCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        child: Text(
          "$name: $correctCount correct",
          style: const TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ));
  }
}
