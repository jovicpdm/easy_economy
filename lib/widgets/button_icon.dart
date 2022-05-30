import 'package:easy_economy/style/pallete.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  ButtonIcon(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  String title;
  IconData icon;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1, color: Pallete().secondary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Pallete().secondary),
            ),
            Icon(
              icon,
              color: Pallete().secondary,
            ),
          ],
        ));
  }
}
