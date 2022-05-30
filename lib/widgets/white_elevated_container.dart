import 'package:flutter/material.dart';

class WhiteElevatedContainer extends StatefulWidget {
  WhiteElevatedContainer({Key? key, required this.children}) : super(key: key);

  List<Widget> children;

  @override
  State<WhiteElevatedContainer> createState() => _WhiteElevatedContainerState();
}

class _WhiteElevatedContainerState extends State<WhiteElevatedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.1,
              blurRadius: 1,
              offset: const Offset(0, 0.5),
            )
          ]),
      child: InkWell(
        child: Column(children: widget.children),
      ),
    );
  }
}
