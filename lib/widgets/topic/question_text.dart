import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String questionText;
  const QuestionText(this.questionText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Text(questionText,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )));
  }
}
