import 'package:flutter/material.dart';

class OverlayScreen {
  /// Create an Overlay on the screen
  /// Declared [overlayEntrys] as List<OverlayEntry> because we might have
  /// more than one Overlay on the screen, so we keep it on a list and remove all at once
  BuildContext _context;
  OverlayState? overlayState;
  List<OverlayEntry>? overlayEntrys;

  void closeAll() {
    for (final overlay in overlayEntrys ?? <OverlayEntry>[]) {
      overlay.remove();
    }
    overlayEntrys?.clear();
  }

  void show() {
    overlayEntrys?.add(
      OverlayEntry(
        builder: (context) {
          return _buildOverlayWidget();
        },
      ),
    );

    overlayState?.insert(overlayEntrys!.last);
  }

  OverlayScreen._create(this._context) {
    overlayState = Overlay.of(_context);
    overlayEntrys = [];
  }

  factory OverlayScreen.of(BuildContext context) {
    return OverlayScreen._create(context);
  }

  Widget _buildOverlayWidget() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        width: 300,
        color: Colors.black,
        height: 300,
        child: const Text("MY CHAT"),
      ),
    );
  }
}
