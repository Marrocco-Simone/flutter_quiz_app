import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../styles/colors.dart';
import '../../providers/stats_provider.dart';

class ResetStatsButton extends StatelessWidget {
  const ResetStatsButton({super.key});

  resetStats(BuildContext context) {
    StatsProvider.resetStats();
    context.pushReplacement('/stats');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: topBarColor,
                padding: const EdgeInsets.all(20)),
            onPressed: () => resetStats(context),
            child: const Text("Reset stats",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ))));
  }
}
