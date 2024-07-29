import 'package:flutter/material.dart';
import '../providers/stats_provider.dart';
import '../services/topic.dart';
import '../widgets/api_widget_wrapper.dart';
import '../screens/topic_screen.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiWidgetWrapper<List<Topic>>(
        () => TopicService.getTopics(),
        (topics) => ApiWidgetWrapper<List<Topic>>(
                () => StatsProvider.setCorrectCountOnTopics(topics),
                (sortedTopics) {
              final int topicId = sortedTopics.last.id;
              const continueUrl = '/practice';
              return TopicScreen(
                topicId: topicId,
                continueUrl: continueUrl,
              );
            }));
  }
}
