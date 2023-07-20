import 'package:flutter/material.dart';

class PolygonSliderThumb extends SliderComponentShape {
  final double thumbRadius;

  const PolygonSliderThumb({
    required this.thumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    // ignore: unused_local_variable
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(1.0)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);
    final rect = Rect.fromCircle(center: center, radius: thumbRadius);

    final rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left, rect.top),
        Offset(rect.right, rect.bottom),
      ),
      Radius.circular(thumbRadius),
    );

    final rrect1 = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left + 3, rect.top + 4),
        Offset(rect.right + 3, rect.bottom + 4),
      ),
      Radius.circular(thumbRadius),
    );
    final rrect2 = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left - 3, rect.top - 4),
        Offset(rect.right - 3, rect.bottom - 4),
      ),
      Radius.circular(thumbRadius),
    );
    final fillPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;

    // ignore: unused_local_variable
    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1)
      ..style = PaintingStyle.stroke;

    final borderPaint1 = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..strokeWidth = 2.8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
      ..style = PaintingStyle.fill;

    final borderPaint2 = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 2.8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rrect1, borderPaint1);
    canvas.drawRRect(rrect2, borderPaint2);

    canvas.drawRRect(rrect, fillPaint);
    // canvas.drawRRect(rrect, borderPaint);
    // canvas.drawArc(
    //   Rect.fromCenter(
    //     center: Offset(0, thumbRadius),
    //     height: 0,
    //     width: thumbRadius,
    //   ),
    //   pi,
    //   pi,
    //   false,
    //   paint as Paint,
    // );
    // Paint thumbPaint1 = Paint()
    //   ..color = Color.fromARGB(255, 49, 49, 49)
    //   ..style = PaintingStyle.fill;
    // canvas.drawArc(
    //   Rect.fromCenter(
    //     center: Offset(thumbRadius, thumbRadius),
    //     height: thumbRadius,
    //     width: thumbRadius,
    //   ),
    //   pi,
    //   pi,
    //   true,
    //   thumbPaint1,
    // );

    // canvas.drawCircle(center, thumbRadius + 10, thumbPaint1);
    // canvas.drawShadow(path, Colors.black, 2.0, false);
    Paint thumbPaint = Paint()
      ..color = const Color.fromARGB(255, 210, 213, 246)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, thumbPaint);
  }
  // Define the slider thumb design here

  // TextSpan span = new TextSpan(
  //   style: new TextStyle(
  //     fontSize: thumbRadius,
  //     fontWeight: FontWeight.w700,
  //     color: Colors.white,
  //   ),
  //   text: sliderValue.round().toString(),
  // );

  // TextPainter tp = new TextPainter(
  //   text: span,
  //   textAlign: TextAlign.center,
  //   textDirection: TextDirection.ltr,
  // );

  // tp.layout();

  // Offset textCenter = Offset(
  //   center.dx - (tp.width / 2),
  //   center.dy - (tp.height / 2),
  // );

  // tp.paint(canvas, textCenter);
}
