import 'package:flutter/material.dart';
import '../../services/topic.dart';
import './correct_answers_text.dart';
import './correct_answers_topic_text.dart';

class CorrectAnswersContainer extends StatelessWidget {
  final List<Topic> sortedTopics;
  const CorrectAnswersContainer(this.sortedTopics, {super.key});

  int getTotalCorrectAnswers(List<Topic> topics) =>
      topics.fold(0, (cum, curr) => cum + curr.correctCount);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          CorrectAnswersText(getTotalCorrectAnswers(sortedTopics)),
          ...sortedTopics
              .map((t) => CorrectAnswersTopicText(t.name, t.correctCount))
        ]));
  }
}
