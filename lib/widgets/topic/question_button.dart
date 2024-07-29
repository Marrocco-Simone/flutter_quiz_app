import 'package:flutter/material.dart';
import '../../services/question.dart';
import '../../styles/colors.dart';

class QuestionButton extends StatelessWidget {
  final Question question;
  final int index;
  final String a;
  final Function(int index) selectOption;
  const QuestionButton(this.question, this.index, this.a, this.selectOption,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: !question.optionsSelected[index]
                  ? buttonColor
                  : question.optionsCorrect[index]
                      ? rightAnswerColor
                      : wrongAnswerColor,
              padding: const EdgeInsets.all(20)),
          onPressed: () => selectOption(index),
          child: Text("${index + 1}: $a",
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              )),
        ));
  }
}
