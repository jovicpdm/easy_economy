import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  CustomTextButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  String text;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(color: Colors.black, letterSpacing: 1.25),
    );
  }
}
