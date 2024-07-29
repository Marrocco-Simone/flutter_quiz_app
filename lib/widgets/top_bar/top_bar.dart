import 'package:flutter/material.dart';
import './redirect_button.dart';
import './name_text.dart';
import '../empty_widget.dart';
import '../../styles/colors.dart';

class TopBar extends StatelessWidget {
  final bool hideHomePageButton;
  final bool hideStatsButton;
  const TopBar(this.hideHomePageButton, this.hideStatsButton, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.sizeOf(context).width >= 1000;

    return Row(children: [
      Expanded(
          child: Container(
              color: topBarColor,
              padding: const EdgeInsets.fromLTRB(70, 10, 40, 10),
              child: Flex(
                direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                children: [
                  isScreenWide
                      ? const Expanded(child: NameText())
                      : const NameText(),
                  hideHomePageButton
                      ? const EmptyWidget()
                      : const RedirectButton('/', 'Go to Main page'),
                  hideStatsButton
                      ? const EmptyWidget()
                      : const SizedBox(width: 30),
                  hideStatsButton
                      ? const EmptyWidget()
                      : const RedirectButton('/stats', 'Go to Statistics'),
                  const SizedBox(width: 40)
                ],
              )))
    ]);
  }
}
