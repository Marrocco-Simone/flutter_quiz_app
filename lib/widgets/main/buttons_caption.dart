import 'package:flutter/material.dart';

class ButtonsCaption extends StatelessWidget {
  final String text;
  const ButtonsCaption(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Text(text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
            )));
  }
}
