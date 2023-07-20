import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final double? textScaleFactor;
  final int milliseconds;
  final String? text;
  final TextStyle? style;
  final bool visibility;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry padding;
  const ErrorText(
      {required this.text,
      this.textScaleFactor,
      this.style,
      this.visibility = true,
      this.alignment,
      required this.padding,
      required this.milliseconds,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
          alignment: alignment,
          child: Stack(
            children: [
              Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visibility ? false : true,
                  child: AnimatedOpacity(
                      duration: Duration(milliseconds: milliseconds),
                      curve: Curves.fastOutSlowIn,
                      opacity: visibility ? 1 : 0,
                      child: Text(
                          textScaleFactor: textScaleFactor,
                          text == null ? '' : text!,
                          style: style))),
              Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visibility ? true : false,
                  child: AnimatedOpacity(
                      duration: Duration(milliseconds: milliseconds),
                      curve: Curves.fastOutSlowIn,
                      opacity: visibility ? 1 : 0,
                      child: Text(
                          textScaleFactor: textScaleFactor,
                          text == null ? '' : text!,
                          style: style))),
            ],
          )),
    );
  }
}
