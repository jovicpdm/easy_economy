import 'package:hive/hive.dart';

final _gainBox = Hive.box("gain");

class GainController {
  List<dynamic> getAll() {
    final data = _gainBox.keys.map((key) {
      final value = _gainBox.get(key);
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

  double getTotalValue(List<dynamic> list) {
    double aux = 0;
    list.forEach((element) {
      aux += element["value"];
    });

    return aux;
  }
}
