import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'topic.dart';

class Question {
  final int id;
  final String questionText;
  final List<String> options;
  final String answerPostPath;
  final String? imageUrl;
  List<bool> optionsSelected;
  List<bool> optionsCorrect;
  Question(this.id, this.questionText, this.options, this.answerPostPath,
      this.imageUrl)
      : optionsSelected = options.map((e) => false).toList(),
        optionsCorrect = options.map((e) => false).toList();

  /* @override
  String toString() {
    return "question: $questionText (id: $id), imageUrl present: ${imageUrl != null}, options: $options";
  } */

  factory Question.fromJson(Map<String, dynamic> data) {
    final List<dynamic> dataOptions = data['options'];
    final List<String> options = dataOptions.map((o) => "$o").toList();

    final q = Question(data['id'], data['question'], options,
        data['answer_post_path'], data['image_url']);
    return q;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': questionText,
      'answer_post_path': answerPostPath,
      'image_url': imageUrl,
      'options': options
    };
  }
}

class QuestionService {
  static String getQuestionsUrl(int topicId) =>
      "${TopicService.topicsUrl}/$topicId/questions";

  static Future<Question> getQuestion(int topicId) async {
    try {
      final endpoint = Uri.parse(getQuestionsUrl(topicId));
      final response = await http.get(endpoint);
      final data = jsonDecode(response.body);
      return Question.fromJson(data);
    } catch (e) {
      log("Error getting question");
      log(e.toString());
      rethrow;
    }
  }
}
