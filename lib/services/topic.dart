import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class Topic implements Comparable<Topic> {
  final int id;
  final String name;
  final String questionPath;
  int correctCount;
  Topic(this.id, this.name, this.questionPath) : correctCount = 0;

  /* @override
  String toString() {
    return "topic: $name (id: $id)";
  } */

  @override
  int compareTo(Topic other) {
    return other.correctCount.compareTo(correctCount);
  }

  Topic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        questionPath = json['question_path'],
        correctCount = 0;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'question_path': questionPath};
  }
}

class TopicService {
  static const topicsUrl = "https://dad-quiz-api.deno.dev/topics";

  static Future<List<Topic>> getTopics() async {
    try {
      final endpoint = Uri.parse(topicsUrl);
      final response = await http.get(endpoint);
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((t) => Topic.fromJson(t)).toList();
    } catch (e) {
      log("Error getting topics");
      log(e.toString());
      rethrow;
    }
  }
}
