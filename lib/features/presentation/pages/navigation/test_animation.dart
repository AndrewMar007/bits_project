import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestAnimationWidget extends StatefulWidget {
  const TestAnimationWidget({super.key});

  @override
  State<TestAnimationWidget> createState() => _TestAnimationWidgetState();
}

class _TestAnimationWidgetState extends State<TestAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pagePlayerController;
  final _duration = const Duration(seconds: 2);
  late Size _size;
  @override
  void initState() {
    super.initState();
    _pagePlayerController =
        AnimationController(vsync: this, duration: _duration);
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TestAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _pagePlayerController.duration = _duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: _size.height * 0.2,
        child: const Placeholder(),
      ),
    );
  }
}
