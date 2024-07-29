import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/widgets/top_bar/top_bar.dart';

class TopBarWrapper extends StatelessWidget {
  final Widget child;
  final bool hideHomePageButton;
  final bool hideStatsButton;
  const TopBarWrapper(
      {super.key,
      required this.child,
      this.hideHomePageButton = false,
      this.hideStatsButton = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TopBar(hideHomePageButton, hideStatsButton), child],
    );
  }
}
