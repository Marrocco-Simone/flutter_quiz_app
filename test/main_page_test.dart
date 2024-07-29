import 'package:flutter_test/flutter_test.dart';
import 'functions/interceptors.dart';
import 'functions/page_loaders.dart';
import 'functions/setup.dart';

Future<void> testTopics(WidgetTester tester) async {
  final topics = await topicInterceptor();
  await mainPageLoader(tester);
  for (var topic in topics) {
    expect(find.text(topic.name), findsOneWidget);
  }
}

Future<void> testTopicsEmpty(WidgetTester tester) async {
  await topicEmptyInterceptor();
  await routerLoader(tester);
  expect(find.text("No topics available"), findsOneWidget);
}

void main() {
  setup();

  testWidgets("Main page, shows topics from API", testTopics);
  testWidgets("Main page, no topics to show", testTopicsEmpty);
}
