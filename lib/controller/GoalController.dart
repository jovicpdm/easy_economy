import 'package:hive/hive.dart';

class GoalController {
  final _goalBox = Hive.box("goal");

  List<dynamic> getAll() {
    final data = _goalBox.keys.map((key) {
      final value = _goalBox.get(key);
      return {
        "key": key,
        "title": value["title"],
        "value": value["value"],
      };
    }).toList();

    List<Map<String, dynamic>> response;

    response = data.reversed.toList();

    return List<dynamic>.from(response);
  }
}
