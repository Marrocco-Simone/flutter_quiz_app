import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_quiz_app/services/answer.dart';
import 'package:flutter_quiz_app/services/question.dart';
import 'package:flutter_quiz_app/services/topic.dart';
import 'functions/page_loaders.dart';

void main() {
  testWidgets("Test error in services", (tester) async {
    expect(() => TopicService.getTopics(), throwsException);
    expect(() => QuestionService.getQuestion(0), throwsException);
    expect(() => AnswerService.postAnswer(0, 0, "answer"), throwsException);

    await routerLoader(tester);
    expect(
        find.text(
            "Error in operation: FormatException: Unexpected end of input (at character 1)"),
        findsOne);
  });
}
