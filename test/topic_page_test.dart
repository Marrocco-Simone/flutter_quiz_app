import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz_app/providers/stats_provider.dart';
import 'package:flutter_quiz_app/services/question.dart';
import 'package:flutter_quiz_app/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'functions/interceptors.dart';
import 'functions/page_loaders.dart';
import 'functions/setup.dart';

String answerText(int i, List<String> options) => "${i + 1}: ${options[i]}";

testQuestionAndAnswers(Question question) {
  final options = question.options;

  expect(find.text(question.questionText), findsOneWidget);
  for (var i = 0; i < options.length; i++) {
    final states = <WidgetState>{};
    final finder = find.widgetWithText(ElevatedButton, answerText(i, options));
    expect(finder, findsOneWidget);
    final button = finder.evaluate().first.widget as ElevatedButton;
    final bgColor = button.style?.backgroundColor?.resolve(states);
    expect(bgColor, buttonColor);
  }
}

Future<(List<String>, SharedPreferences)> testQuestionAndAnswersInPage(
    WidgetTester tester) async {
  final prefs = await sharedPreferencesInterceptor({});
  final question = await questionInterceptor();
  await topicPageLoader(tester);
  testQuestionAndAnswers(question);
  return (question.options, prefs);
}

Future<void> testAnswerFeedback(WidgetTester tester) async {
  final (options, prefs) = await testQuestionAndAnswersInPage(tester);
  for (var i = 0; i < options.length; i++) {
    final correctOption = i == options.length - 1;

    final finderBefore =
        find.widgetWithText(ElevatedButton, answerText(i, options));

    await tester.tap(finderBefore);
    await tester.pumpAndSettle();

    final states = <WidgetState>{};
    final finderAfter =
        find.widgetWithText(ElevatedButton, answerText(i, options));
    expect(finderAfter, findsOneWidget);
    final button = finderAfter.evaluate().first.widget as ElevatedButton;
    final bgColor = button.style?.backgroundColor?.resolve(states);
    expect(bgColor, correctOption ? rightAnswerColor : wrongAnswerColor);

    if (correctOption) {
      expect(find.text("Go to the next question"), findsOneWidget);
      expect(
          prefs.getString(statsDataKey),
          jsonEncode(
            {"0": 1},
          ));
    } else {
      expect(find.text("Go to the next question"), findsNothing);
      expect(prefs.getString(statsDataKey), null);
    }
  }
}

Future<void> testPractice(WidgetTester tester) async {
  final topics = await topicInterceptor();
  final initialValues = {
    "${topics[0].id}": 5,
    "${topics[1].id}": 9,
    "${topics[2].id}": 3
  };
  // * topic with lower count
  final question = await questionInterceptor(topicId: topics[2].id);
  final prefs = await sharedPreferencesInterceptor(initialValues);
  expect(prefs.getString(statsDataKey), jsonEncode(initialValues));
  await practicePageLoader(tester);
  testQuestionAndAnswers(question);

  expect(find.text("Go to the next question"), findsNothing);
  final correctAnswerFinder = find.widgetWithText(ElevatedButton,
      answerText(question.options.length - 1, question.options));
  await tester.tap(correctAnswerFinder);
  await tester.pumpAndSettle();
  final goNextQuestion = find.text("Go to the next question");
  expect(goNextQuestion, findsOneWidget);
  expect(
      prefs.getString(statsDataKey),
      jsonEncode({
        ...initialValues,
        "${topics[2].id}": initialValues["${topics[2].id}"]! + 1
      }));

  await tester.scrollUntilVisible(goNextQuestion, 100);
  await tester.tap(goNextQuestion);
  await tester.pumpAndSettle();
  expect(find.text("Go to the next question"), findsNothing);
}

void main() {
  setup();

  testWidgets(
      "Topic page, show question and answers", testQuestionAndAnswersInPage);
  testWidgets("Topic page, answers buttons give feedback when clicked",
      testAnswerFeedback);
  testWidgets("Practice mode", testPractice);
}
