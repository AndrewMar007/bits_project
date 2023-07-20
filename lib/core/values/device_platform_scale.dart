import 'dart:io';

import 'package:flutter/material.dart';

// ignore: body_might_complete_normally_nullable
double? scaleSmallDevice(BuildContext context) {
  final size = MediaQuery.of(context).size;
  if (Platform.isAndroid) {
    if (size.height < 700) {
      return 1.02;
    }
    if (size.height < 750) {
      return 1.02;
    }
    if (size.height < 800) {
      return 1.02;
    }
    if (size.height < 900) {
      return 1.03;
    }
    return 1.03;
  } else if (Platform.isIOS) {
    if (size.height < 700) {
      return 1.02;
    }
    if (size.height < 750) {
      return 1.02;
    }
    if (size.height < 850) {
      return 0.98;
    }
    if (size.height < 900) {
      return 1.0;
    }
    return 0.9;
  }
}

// ignore: body_might_complete_normally_nullable
double? textScaleRatio(BuildContext context) {
  final size = MediaQuery.of(context).size;
  if (Platform.isAndroid) {
    if (size.height < 700) {
      return 0.6;
    }
    if (size.height < 750) {
      return 0.65;
    }
    if (size.height < 850) {
      return 1.0;
    }
    if (size.height < 900) {
      return 1.0;
    }
    return 1.0;
  }
  if (Platform.isIOS) {
    // if (size.height < 700) {
    //   return 0.6;
    // }
    // if (size.height < 750) {
    //   return 0.65;
    // }
    if (size.height < 850) {
      return 0.75;
    }
    if (size.height < 900) {
      return 0.75;
    }
    return 0.85;
  }
}

// ignore: body_might_complete_normally_nullable
double? textFormTopRatio(BuildContext context) {
  final size = MediaQuery.of(context).size;
  if (Platform.isAndroid) {
    if (size.height < 700) {
      return 0.11;
    }
    if (size.height < 750) {
      return 0.11;
    }
    if (size.height < 800) {
      return 0.08;
    }
    if (size.height < 900) {
      return 0.1;
    }
    return 0.1;
  }
  if (Platform.isIOS) {
    // if (size.height < 700) {
    //   return 0.11;
    // }
    // if (size.height < 750) {
    //   return 0.1;
    // }
    if (size.height < 800) {
      return 0.07;
    }
    if (size.height < 900) {
      return 0.08;
    }
    return 0.1;
  }
}
