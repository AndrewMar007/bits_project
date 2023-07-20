import 'package:flutter/material.dart';

class TextGradients {
  static List<Color> gradientColors = [
    const Color.fromARGB(255, 255, 0, 255),
    const Color.fromARGB(255, 252, 248, 21),
    const Color.fromARGB(255, 2, 255, 107),
  ];
  static List<Color> dividerGradient1 = const [
    Color.fromARGB(255, 255, 56, 228),
    Color.fromARGB(255, 111, 1, 255),
  ];
  static List<Color> dividerGradient2 = const [
    Color.fromARGB(255, 255, 238, 5),
    Color.fromARGB(255, 255, 81, 1),
  ];
  static List<Color> dividerGradient3 = const [
    Color.fromARGB(255, 7, 158, 52),
    Color.fromARGB(255, 2, 255, 107)
  ];
  // static LinearGradient dividerGradient1 = const LinearGradient(colors: <Color>[
  //   Color.fromARGB(255, 255, 56, 228),
  //   Color.fromARGB(255, 111, 1, 255),
  // ]);
  // static LinearGradient dividerGradient2 = const LinearGradient(colors: <Color>[
  //   Color.fromARGB(255, 255, 238, 5),
  //   Color.fromARGB(255, 255, 81, 1),
  // ]);
  static Shader linearGradient = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 111, 1, 255),
      Color.fromARGB(255, 255, 56, 228)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static final Shader linearGradient1 = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 255, 73, 1),
      Color.fromARGB(255, 251, 255, 2)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static List<Shader> shaderList = [
    linearGradient,
    linearGradient1,
    linearGradient2
  ];

  static List<List<Color>> dividerGradientList = [
    dividerGradient1,
    dividerGradient2,
    dividerGradient3
  ];

  static final Shader linearGradient2 = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 7, 158, 52),
      Color.fromARGB(255, 2, 255, 107)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static final Shader linearGradient3 = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 124, 8, 153),
      Color.fromARGB(255, 211, 8, 8)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static final Shader linearGradient4 = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 69, 122, 223),
      Color.fromARGB(255, 7, 238, 255)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}

List listGradient = [
  const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 111, 1, 255),
      Color.fromARGB(255, 255, 56, 228)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 80.0, 70.0)),
  const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 255, 73, 1),
      Color.fromARGB(255, 251, 255, 2)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 80.0, 70.0)),
  const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 7, 158, 52),
      Color.fromARGB(255, 2, 255, 107)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 80.0, 70.0)),
  const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 50, 16, 172),
      Color.fromARGB(255, 7, 238, 255)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 80.0, 70.0)),
];
