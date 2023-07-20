import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'package:flutter/services.dart';

import '../../../../core/values/config.dart';

class PolimorphicFormField extends StatelessWidget {
  const PolimorphicFormField({
    Key? key,
    this.hintFontSize,
    required this.contHeight,
    required this.contWidth,
    required this.height,
    required this.width,
    required this.hintText,
    this.errorText,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    required this.isPassword,
    this.onTap,
    this.controller,
  }) : super(key: key);
  final double? hintFontSize;
  final double contHeight;
  final double contWidth;
  final double height;
  final double width;
  final String hintText;
  final Function()? onTap;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    //final double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    const backgroundColor = Color.fromARGB(255, 250, 250, 250);
    Offset distance = const Offset(5, 5);
    double blur = 3.0;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                offset: -distance,
                color: const Color.fromARGB(255, 245, 245, 245),
                blurRadius: blur,
                inset: true),
            BoxShadow(
                offset: distance,
                color: const Color.fromARGB(136, 0, 0, 0),
                blurRadius: blur,
                inset: true),
          ]),
      child: TextFormField(
        style: TextStyle(
            color: const Color.fromARGB(255, 53, 53, 53),
            fontSize: hintFontSize,
            fontFamily: BitsFont.segoeItalicFont),
        onChanged: onChanged,
        obscureText: isPassword,
        validator: validator,
        onTap: onTap,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: contHeight, horizontal: contWidth),
          border: InputBorder.none,
          // border: GradientOutlineInputBorder(
          //     borderRadius: BorderRadius.circular(30.0),
          //     width: 2.0,
          //     gradient: const LinearGradient(colors: [
          //       Color.fromARGB(255, 35, 255, 255),
          //       Color.fromARGB(255, 229, 35, 210),
          //     ])),
          hintText: hintText,
          errorText: errorText,

          hintStyle: TextStyle(
              color: const Color.fromARGB(255, 99, 99, 99),
              fontFamily: BitsFont.segoeItalicFont,
              fontSize: hintFontSize,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
