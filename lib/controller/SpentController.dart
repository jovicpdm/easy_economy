import 'package:hive/hive.dart';

final _spentBox = Hive.box("spent");

class SpentController {
  List<dynamic> getAll() {
    final data = _spentBox.keys.map((key) {
      final value = _spentBox.get(key);
      return {
        "key": key,
        "title": value["title"],
        "value": value["value"],
        "status": value["status"],
        "date": value['date']
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
