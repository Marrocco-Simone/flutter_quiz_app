import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/topic.dart';

/// {topicId: correctAnswerCount}
typedef StatsData = Map<String, int>;
const statsDataKey = 'statsDataKey';

class StatsProvider {
  static Future<StatsData> getStats() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(statsDataKey)) return {};

    final dataString = prefs.getString(statsDataKey)!;
    Map<String, dynamic> dataDynamic = jsonDecode(dataString);
    StatsData data =
        dataDynamic.map((key, value) => MapEntry(key, int.parse("$value")));
    return data;
  }

  static increaseStat(int topicId) async {
    final topicIdKey = "$topicId";
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(statsDataKey)) {
      final StatsData data = {topicIdKey: 1};
      final newDataString = jsonEncode(data);
      await prefs.setString(statsDataKey, newDataString);
    } else {
      final dataString = prefs.getString(statsDataKey)!;
      Map<String, dynamic> dataDynamic = jsonDecode(dataString);
      StatsData data =
          dataDynamic.map((key, value) => MapEntry(key, int.parse("$value")));
      data[topicIdKey] =
          data.containsKey(topicIdKey) ? data[topicIdKey]! + 1 : 1;
      final newDataString = jsonEncode(data);
      await prefs.setString(statsDataKey, newDataString);
    }
  }

  static resetStats() {
    SharedPreferences.getInstance().then((prefs) => prefs.remove(statsDataKey));
  }

  static Future<List<Topic>> setCorrectCountOnTopics(List<Topic> topics) async {
    final statsData = await StatsProvider.getStats();

    for (Topic t in topics) {
      final tKey = "${t.id}";
      if (!statsData.containsKey(tKey)) continue;
      t.correctCount = statsData[tKey]!;
    }

    topics.sort();

    return topics;
  }
}
