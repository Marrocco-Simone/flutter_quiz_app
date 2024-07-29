import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz_app/providers/stats_provider.dart';
import 'package:flutter_quiz_app/services/topic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'functions/interceptors.dart';
import 'functions/page_loaders.dart';
import 'functions/setup.dart';

Future<(List<Topic>, Map<String, int>, SharedPreferences prefs)> testTotalCount(
    WidgetTester tester) async {
  final topics = await topicInterceptor();

  final initialValues = {
    "${topics[0].id}": 3,
    "${topics[1].id}": 9,
    "${topics[2].id}": 5
  };
  final totalCount = initialValues.values.reduce((a, b) => a + b);
  final prefs = await sharedPreferencesInterceptor(initialValues);

  await statsPageLoader(tester);

  expect(find.text("Total correct answers: $totalCount"), findsOneWidget);

  return (topics, initialValues, prefs);
}

Future<(List<Topic>, SharedPreferences prefs)> testSingleTopicCount(
    WidgetTester tester) async {
  final (topics, initialValues, prefs) = await testTotalCount(tester);

  for (var topic in topics) {
    expect(find.text("${topic.name}: ${initialValues["${topic.id}"]} correct"),
        findsOneWidget);
  }

  expect(
    tester.allWidgets
        .where((x) => x.runtimeType == Text)
        .map((x) => (x as Text).data)
        .where(
            (x) => x != null && x.contains("correct") && !x.contains("Total"))
        .toList(),
    // * hardcoded based on initialValues
    [
      "${topics[1].name}: ${initialValues["${topics[1].id}"]} correct",
      "${topics[2].name}: ${initialValues["${topics[2].id}"]} correct",
      "${topics[0].name}: ${initialValues["${topics[0].id}"]} correct",
    ],
  );

  return (topics, prefs);
}

Future<void> testResetStats(WidgetTester tester) async {
  final (topics, prefs) = await testSingleTopicCount(tester);

  final resetButton = find.text("Reset stats");
  expect(resetButton, findsOneWidget);
  await tester.scrollUntilVisible(resetButton, 100);
  await tester.tap(resetButton);
  await tester.pumpAndSettle();

  expect(find.text("Total correct answers: 0"), findsOneWidget);
  for (var topic in topics) {
    expect(find.text("${topic.name}: 0 correct"), findsOneWidget);
  }

  expect(prefs.containsKey(statsDataKey), false);
  expect(prefs.getString(statsDataKey), null);
}

void main() {
  setup();

  testWidgets("Stats page, shows total correct count", testTotalCount);
  testWidgets("Stats page, shows ordered correct counts per topic",
      testSingleTopicCount);
  testWidgets("Stats page, reset stats button", testResetStats);
}
