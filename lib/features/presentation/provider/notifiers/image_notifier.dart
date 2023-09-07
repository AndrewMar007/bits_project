import 'package:flutter/material.dart';

class ImageNotifier extends ValueNotifier<ImageNotifierState> {
  ImageNotifier() : super(_initialValue);
  static const _initialValue = ImageNotifierState.loading;
}

enum ImageNotifierState { loading, complete }
