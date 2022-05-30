import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../style/pallete.dart';

class GeneralController {
  final _spentBox = Hive.box("spent");
  final _gainBox = Hive.box("gain");
  final _goalBox = Hive.box("goal");
  final _valueSaved = Hive.box("valueSaved");

  void deleteItem(int key, String item) async {
    if (item == "gain") {
      _gainBox.delete(key);
    } else if (item == "goal") {
      _goalBox.delete(key);
    } else if (item == "valueSaved") {
      _valueSaved.delete(key);
    } else {
      _spentBox.delete(key);
    }
  }

  double getTotalValue(List list) {
    double aux = 0;
    list.forEach((element) {
      aux += element["value"];
    });

    return aux;
  }

  Future<void> createItem(Map<String, dynamic> newItem, context, item) async {
    if (item == "gain") {
      await _gainBox.add(newItem);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Pallete().primary,
          content: Text(
            "Ganho adicionado com sucesso",
            style: TextStyle(color: Pallete().secondary),
          )));
    } else if (item == "spent") {
      await _spentBox.add(newItem);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Pallete().primary,
          content: Text(
            "Gasto adicionado com sucesso",
            style: TextStyle(color: Pallete().secondary),
          )));
    } else if (item == "goal") {
      await _goalBox.add(newItem);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Pallete().primary,
          content: Text(
            "Meta adicionada com sucesso",
            style: TextStyle(color: Pallete().secondary),
          )));
    } else if (item == "valueSaved") {
      await _valueSaved.add(newItem);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Pallete().primary,
          content: Text(
            "Valor poupado adicionado com sucesso",
            style: TextStyle(color: Pallete().secondary),
          )));
    }
  }
}
