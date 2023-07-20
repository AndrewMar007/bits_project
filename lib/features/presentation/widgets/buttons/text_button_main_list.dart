import 'package:flutter/material.dart';

import '../../../../core/values/config.dart';

class TextButtonHome extends StatelessWidget {
  final double? height;
  final double? width;
  final Shader? shader;
  final String text;
  final double? fontSize;
  const TextButtonHome(
      {super.key,
      required this.text,
      this.fontSize,
      this.height,
      this.width,
      this.shader});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(minimumSize: Size(width!, height!)),
        onPressed: () {},
        child: Text(
          text,
          textScaleFactor: fontSize,
          style: TextStyle(
            shadows: const <Shadow>[
              Shadow(
                  blurRadius: 5.0,
                  offset: Offset(1, 1),
                  color: Color.fromARGB(255, 125, 9, 179)),
            ],
            foreground: Paint()..shader = shader,
            fontFamily: BitsFont.spaceMono,
          ),
        ),
      ),
    );
  }
}
