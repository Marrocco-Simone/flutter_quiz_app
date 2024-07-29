import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../styles/colors.dart';
import '../../services/topic.dart';

class TopicButton extends StatelessWidget {
  final Topic t;
  const TopicButton(this.t, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.all(20)),
            onPressed: () => context.go("/topic/${t.id}"),
            child: Text(t.name,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ))));
  }
}
