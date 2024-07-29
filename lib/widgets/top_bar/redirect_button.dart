import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../styles/colors.dart';

class RedirectButton extends StatelessWidget {
  final String url;
  final String text;
  const RedirectButton(this.url, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: topBarButtonColor,
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () => context.go(url),
        child: Text(text,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
            )));
  }
}
