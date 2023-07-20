import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;

  const HeaderWidget(this._height, {Key? key}) : super(key: key);
  //static const primaryColor = Colors.black;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _HeaderWidgetState createState() => _HeaderWidgetState(
        _height,
      );
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _height;

  _HeaderWidgetState(
    this._height,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          clipper: ShapeClipper([
            Offset(width / 5, _height),
            Offset(width / 10 * 5, _height - 60),
            Offset(width / 5 * 4, _height + 20),
            Offset(width, _height - 18)
          ]),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 44, 192).withOpacity(0.8),
                    const Color.fromARGB(255, 15, 247, 255).withOpacity(0.4)
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(2.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        ClipPath(
          clipper: ShapeClipper([
            Offset(width / 3, _height + 20),
            Offset(width / 10 * 8, _height - 60),
            Offset(width / 5 * 4, _height - 60),
            Offset(width, _height - 20)
          ]),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 44, 192).withOpacity(0.8),
                    const Color.fromARGB(255, 15, 247, 255).withOpacity(0.8),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        ClipPath(
          clipper: ShapeClipper([
            Offset(width / 5, _height),
            Offset(width / 2, _height - 40),
            Offset(width / 5 * 4, _height - 80),
            Offset(width, _height - 20)
          ]),
          child: Container(
            decoration: const BoxDecoration(
              // color: Color.fromARGB(255, 17, 5, 182).withOpacity(0.4),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 33, 36, 226),
                Color.fromARGB(255, 253, 49, 192),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  final List<Offset> _offsets;
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
