import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/widgets/main/practice_button.dart';
import 'package:flutter_quiz_app/widgets/main/topic_button.dart';
import '../widgets/main/buttons_caption.dart';
import '../widgets/main/no_topics_text.dart';
import '../widgets/api_widget_wrapper.dart';
import '../services/topic.dart';
import '../widgets/top_bar_wrapper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiWidgetWrapper<List<Topic>>(
        () => TopicService.getTopics(),
        (topics) => TopBarWrapper(
            hideHomePageButton: true, child: TopicChoice(topics)));
  }
}

class TopicChoice extends StatelessWidget {
  final List<Topic> topics;
  const TopicChoice(this.topics, {super.key});

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) {
      return const NoTopicsText();
    }

    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ButtonsCaption("Choose a topic"),
            ...topics.map((t) => TopicButton(t)),
            const ButtonsCaption("Practice your worst subjects"),
            const PracticeButton()
          ],
        ));
  }
}
