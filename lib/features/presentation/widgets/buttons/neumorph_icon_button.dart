import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphIconButton extends StatefulWidget {
  final IconData? icon;
  final double? size;
  final double? textScaleFactor;
  final String? fontFamily;
  final double? height;
  final double? width;
  final double radius;
  final Function()? onTap;
  final String? text;
  final double? fontSize;
  const NeumorphIconButton(this.radius,
      {this.fontFamily,
      this.icon,
      this.size,
      this.fontSize,
      this.text,
      this.onTap,
      this.width,
      this.height,
      this.textScaleFactor,
      super.key});

  @override
  State<NeumorphIconButton> createState() => _NeumorphIconButtonState();
}

class _NeumorphIconButtonState extends State<NeumorphIconButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    //const backgroundColor = Color.fromARGB(255, 194, 194, 194);
    Offset distance = isPressed ? const Offset(2, 2) : const Offset(2, 2);
    double blur = isPressed ? 2.0 : 7.0;
    return GestureDetector(
      onTapUp: (_) => setState(() {
        isPressed = false;
      }),
      onTapDown: (_) => setState(() {
        isPressed = true;
      }),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: const Color.fromARGB(255, 212, 215, 255),
          boxShadow: [
            BoxShadow(
                offset: -distance,
                color: const Color.fromARGB(255, 255, 255, 255),
                blurRadius: blur,
                inset: isPressed),
            BoxShadow(
                offset: distance,
                color: const Color.fromARGB(95, 0, 0, 0),
                blurRadius: blur,
                inset: isPressed),
          ],
        ),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: Center(
              child: Icon(
            widget.icon,
            size: widget.size,
            color: Colors.black,
          )),
        ),
      ),
    );
  }
}
