import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nock/nock.dart';
import 'package:flutter_quiz_app/providers/stats_provider.dart';
import 'package:flutter_quiz_app/services/answer.dart';
import 'package:flutter_quiz_app/services/question.dart';
import 'package:flutter_quiz_app/services/topic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> topicEmptyInterceptor() async {
  final interceptor = nock(TopicService.topicsUrl).get("")
    ..reply(
      200,
      [],
    );
  interceptor.persist();

  for (var _ = 0; _ < 2; _++) {
    final response = await http.get(Uri.parse(TopicService.topicsUrl));
    expect(interceptor.isDone, true);
    expect(response.statusCode, 200);
    expect(response.body, '[]');
  }
}

Future<List<Topic>> topicInterceptor() async {
  final topic0 = Topic(0, "my topic 0", "");
  final topic1 = Topic(1, "my topic 1", "");
  final topic2 = Topic(2, "my topic 2", "");
  final topics = [topic0, topic1, topic2];
  final topicJson = jsonEncode(topics);
  final interceptor = nock(TopicService.topicsUrl).get("")
    ..reply(
      200,
      topicJson,
    );
  interceptor.persist();

  for (var _ = 0; _ < 2; _++) {
    final response = await http.get(Uri.parse(TopicService.topicsUrl));
    expect(interceptor.isDone, true);
    expect(response.statusCode, 200);
    expect(response.body, topicJson);
  }

  return topics;
}

Future<Question> questionInterceptor({int topicId = 0}) async {
  final options = ["answer 1", 'answer 2', 'answer 3'];
  final question = Question(0, "my question?", options, '', null);
  final questionjson = jsonEncode(question);
  final interceptor = nock(QuestionService.getQuestionsUrl(topicId)).get("")
    ..reply(
      200,
      questionjson,
    );
  interceptor.persist();

  // * test api works multiple times
  for (var _ = 0; _ < 2; _++) {
    final response =
        await http.get(Uri.parse(QuestionService.getQuestionsUrl(topicId)));
    expect(interceptor.isDone, true);
    expect(response.statusCode, 200);
    expect(response.body, questionjson);
  }

  for (var option in options) {
    final interceptorPostAnswer =
        nock(AnswerService.getAnswerUrl(topicId, question.id))
            .post("", jsonEncode({'answer': option}))
          ..reply(
            200,
            {'correct': option == options.last},
          );
    interceptorPostAnswer.persist();
    final response =
        await AnswerService.postAnswer(topicId, question.id, option);
    expect(response, option == options.last);
  }

  return question;
}

Future<SharedPreferences> sharedPreferencesInterceptor(
    Map<String, int> initialValues) async {
  SharedPreferences.setMockInitialValues(
      {statsDataKey: jsonEncode(initialValues)});
  final prefs = await SharedPreferences.getInstance();
  if (initialValues.isEmpty) {
    prefs.remove(statsDataKey);
    expect(prefs.containsKey(statsDataKey), false);
    expect(prefs.getString(statsDataKey), null);
  } else {
    expect(prefs.containsKey(statsDataKey), true);
    expect(prefs.getString(statsDataKey), jsonEncode(initialValues));
  }
  return prefs;
}
