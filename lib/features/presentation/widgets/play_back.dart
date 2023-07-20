import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class PlayBack extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final child;
  // ignore: prefer_typing_uninitialized_variables
  final height;
  // ignore: prefer_typing_uninitialized_variables
  final width;
  const PlayBack({this.height, this.width, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: const Color.fromARGB(255, 248, 203, 245).withOpacity(0.5),
        boxShadow: [
          BoxShadow(
              offset: -const Offset(2, 2),
              color: const Color.fromARGB(255, 255, 255, 255),
              blurRadius: 3.0,
              inset: true),
          const BoxShadow(
              offset: Offset(7, 7),
              color: Color.fromARGB(95, 0, 0, 0),
              blurRadius: 3.0,
              inset: true),
        ],
      ),
    );
  }
}
