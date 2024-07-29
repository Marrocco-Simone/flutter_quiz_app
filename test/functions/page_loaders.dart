import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz_app/routes/router.dart';
import 'interceptors.dart';
// import 'show_all_created_widgets.dart';

Future<void> routerLoader(WidgetTester tester) async {
  final widget = MaterialApp.router(routerConfig: getRouter());
  await tester.pumpWidget(widget);
  expect(find.text("Waiting for an operation result."), findsOneWidget);
  await tester.pumpAndSettle();

  // showAllCreatedWidgets(tester);
}

Future<void> mainPageLoader(WidgetTester tester) async {
  await routerLoader(tester);
  expect(find.text("Quiz App!"), findsOneWidget);
  expect(find.text("Go to Statistics"), findsOneWidget);
  expect(find.text("Choose a topic"), findsOneWidget);
  expect(find.text("Practice your worst subjects"), findsOneWidget);
  expect(find.text("Practice"), findsOneWidget);
}

Future<void> statsPageLoader(WidgetTester tester) async {
  await mainPageLoader(tester);
  final goToStatsButton = find.text("Go to Statistics");
  expect(goToStatsButton, findsOneWidget);
  await tester.tap(goToStatsButton);
  await tester.pumpAndSettle();
}

Future<void> topicPageLoader(WidgetTester tester) async {
  final topics = await topicInterceptor();
  await mainPageLoader(tester);

  final firstTopicButton = find.text(topics.first.name);
  expect(firstTopicButton, findsOneWidget);
  await tester.tap(firstTopicButton);
  await tester.pumpAndSettle();
}

Future<void> practicePageLoader(WidgetTester tester) async {
  await mainPageLoader(tester);
  final goToPracticeButton = find.text("Practice");
  expect(goToPracticeButton, findsOneWidget);
  await tester.scrollUntilVisible(goToPracticeButton, 100);
  await tester.tap(goToPracticeButton);
  await tester.pumpAndSettle();
}
