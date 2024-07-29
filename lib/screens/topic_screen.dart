import 'package:flutter/material.dart';
import '../widgets/topic/go_next_question_button.dart';
import '../widgets/topic/question_button.dart';
import '../widgets/topic/question_text.dart';
import '../widgets/topic/image_veiwer.dart';
import '../providers/stats_provider.dart';
import '../services/answer.dart';
import '../widgets/api_widget_wrapper.dart';
import '../services/question.dart';
import '../widgets/top_bar_wrapper.dart';
import '../widgets/empty_widget.dart';

class TopicScreen extends StatelessWidget {
  final int topicId;
  final String continueUrl;
  const TopicScreen(
      {super.key, required this.topicId, required this.continueUrl});

  @override
  Widget build(BuildContext context) {
    return ApiWidgetWrapper<Question>(
        () => QuestionService.getQuestion(topicId),
        (question) => TopBarWrapper(
            child: QuestionResponses(topicId, continueUrl, question)));
  }
}

class QuestionResponses extends StatefulWidget {
  final int topicId;
  final String continueUrl;
  final Question startingQuestion;
  const QuestionResponses(this.topicId, this.continueUrl, this.startingQuestion,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return QuestionResponsesState();
  }
}

class QuestionResponsesState extends State<QuestionResponses> {
  late Question question;
  bool correctAnswer = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      question = widget.startingQuestion;
    });
  }

  selectOption(int index) async {
    if (correctAnswer) return;
    if (question.optionsSelected[index]) return;

    final int topicId = widget.topicId;
    final int questionId = question.id;
    final String answer = question.options[index];
    final bool result =
        await AnswerService.postAnswer(topicId, questionId, answer);
    question.optionsSelected[index] = true;
    question.optionsCorrect[index] = result;
    if (result) {
      correctAnswer = true;
      await StatsProvider.increaseStat(topicId);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          QuestionText(question.questionText),
          ImageVeiwer(question.imageUrl),
          Column(
            children: question.options
                .asMap()
                .map((index, a) => MapEntry(
                    index, QuestionButton(question, index, a, selectOption)))
                .values
                .toList(),
          ),
          correctAnswer
              ? GoNextQuestionButton(widget.continueUrl)
              : const EmptyWidget(),
        ]));
  }
}
