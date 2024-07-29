import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'question.dart';

class AnswerService {
  static String getAnswerUrl(int topicId, int questionId) =>
      "${QuestionService.getQuestionsUrl(topicId)}/$questionId/answers";

  static Future<bool> postAnswer(
      int topicId, int questionId, String answer) async {
    try {
      final endpoint = Uri.parse(getAnswerUrl(topicId, questionId));
      final body = jsonEncode({'answer': answer});
      final response = await http.post(endpoint, body: body);
      final data = jsonDecode(response.body);
      return data['correct'];
    } catch (e) {
      log("Error getting answer");
      log(e.toString());
      rethrow;
    }
  }
}
