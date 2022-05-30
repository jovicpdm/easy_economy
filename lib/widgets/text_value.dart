import 'package:flutter/material.dart';

class TextValue extends StatefulWidget {
  TextValue({Key? key, required this.value, required this.color})
      : super(key: key);
  String value;
  Color color;

  @override
  State<TextValue> createState() => _TextValueState();
}

class _TextValueState extends State<TextValue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.value,
        style: TextStyle(
            color: widget.color, fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
