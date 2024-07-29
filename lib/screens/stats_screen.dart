import 'package:flutter/material.dart';
import '../widgets/stats/correct_answers_container.dart';
import '../widgets/stats/reset_stats_button.dart';
import '../providers/stats_provider.dart';
import '../widgets/api_widget_wrapper.dart';
import '../services/topic.dart';
import '../widgets/top_bar_wrapper.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiWidgetWrapper<List<Topic>>(
        () => TopicService.getTopics(),
        (topics) =>
            TopBarWrapper(hideStatsButton: true, child: ShowStats(topics)));
  }
}

class ShowStats extends StatelessWidget {
  final List<Topic> topics;
  const ShowStats(this.topics, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApiWidgetWrapper<List<Topic>>(
            () => StatsProvider.setCorrectCountOnTopics(topics),
            (sortedTopics) => CorrectAnswersContainer(sortedTopics)),
        const ResetStatsButton()
      ],
    );
  }
}
