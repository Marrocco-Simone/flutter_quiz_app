import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../styles/colors.dart';

class GoNextQuestionButton extends StatelessWidget {
  final String continueUrl;
  const GoNextQuestionButton(this.continueUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: topBarColor,
                padding: const EdgeInsets.all(20)),
            onPressed: () => context.pushReplacement(continueUrl),
            child: const Text("Go to the next question",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ))));
  }
}
