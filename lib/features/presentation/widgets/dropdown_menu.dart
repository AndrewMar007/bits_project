import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../../core/values/config.dart';

class DropDownMenu extends StatefulWidget {
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final double? height;
  final double? width;
  final String? value;
  const DropDownMenu(
      {this.items,
      this.value,
      this.onChanged,
      this.height,
      this.width,
      super.key});
  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  static const backgroundColor = Color.fromARGB(255, 250, 250, 250);
  Offset distance = const Offset(5, 5);
  double blur = 3.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
                offset: -distance,
                color: const Color.fromARGB(255, 255, 255, 255),
                blurRadius: blur,
                inset: true),
            BoxShadow(
                offset: distance,
                color: const Color.fromARGB(136, 0, 0, 0),
                blurRadius: blur,
                inset: true),
          ]),
      child: DropdownButtonFormField(
          dropdownColor: Colors.white,
          focusColor: Colors.transparent,
          style: const TextStyle(
              color: Color.fromARGB(255, 59, 59, 59),
              fontFamily: BitsFont.segoeItalicFont),
          decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20)),
          elevation: 0,
          items: widget.items,
          value: widget.value,
          onChanged: widget.onChanged),
    );
  }
}
