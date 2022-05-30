import 'package:easy_economy/style/pallete.dart';
import 'package:flutter/material.dart';

class TextLegend extends StatefulWidget {
  TextLegend({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  State<TextLegend> createState() => _TextLegendState();
}

class _TextLegendState extends State<TextLegend> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(color: Pallete().blackText, fontSize: 12),
    );
  }
}
