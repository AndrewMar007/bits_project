import 'package:bits_project/features/presentation/widgets/seek_widget/rounded_slider_thumb.dart';
import 'package:flutter/material.dart';

class SeekWidget extends StatefulWidget {
  final double currentPosition;
  final double shadowHeight;
  final double shadowWidth;
  final double width;
  final double height;
  final double duration;
  final Function(double)? onChanged;
  // final Function(Duration) seekTo;

  const SeekWidget({
    super.key,
    required this.shadowHeight,
    required this.shadowWidth,
    required this.height,
    required this.width,
    required this.currentPosition,
    required this.duration,
    this.onChanged,
    // required this.seekTo,
  });

  @override
  State<SeekWidget> createState() => _SeekWidgetState();
}

class _SeekWidgetState extends State<SeekWidget> {
  // bool listenOnlyUserInterraction = false;
  // double get percent => widget.duration.inMilliseconds == 0
  //     ? 0
  //     : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  // @override
  // void initState() {
  //   super.initState();
  //   _visibleValue = widget.currentPosition;
  // }

  // @override
  // void didUpdateWidget(SeekWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (!listenOnlyUserInterraction) {
  //     _visibleValue = widget.currentPosition;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: widget.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: widget.shadowHeight,
                width: widget.shadowWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(5, 2),
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5.0),
                      BoxShadow(
                          offset: -const Offset(4, 2),
                          color: Colors.white.withOpacity(0.9),
                          blurRadius: 10.0),
                    ]),
              ),
              SliderTheme(
                data: SliderThemeData(
                  overlayColor: Colors.transparent,
                  trackHeight: widget.height,
                  activeTrackColor: const Color.fromARGB(255, 201, 206, 255),
                  trackShape: const RoundedRectSliderTrackShape(),
                  inactiveTrackColor: const Color.fromARGB(255, 216, 216, 250),
                  thumbShape: const PolygonSliderThumb(thumbRadius: 10.0),
                  thumbColor: const Color.fromARGB(255, 210, 213, 246),
                ),
                child: Slider(
                  min: 0,
                  max: widget.duration,
                  value: widget.currentPosition,
                  onChanged: widget.onChanged,
                  // max: widget.duration.inMilliseconds.toDouble(),
                  // value: percent * widget.duration.inMilliseconds.toDouble(),
                  // style: SliderStyle(
                  //     depth: 4.0,
                  //     accent: Color.fromARGB(255, 210, 213, 246),
                  //     variant: Color.fromARGB(255, 210, 213, 246)),
                  // onChangeEnd: (newValue) {
                  //   setState(() {
                  //     listenOnlyUserInterraction = false;
                  //     widget.seekTo(_visibleValue);
                  //   });
                  // },
                  // onChangeStart: (_) {
                  //   setState(() {
                  //     listenOnlyUserInterraction = true;
                  //   });
                  // },
                  // onChanged: (newValue) {
                  //   setState(() {
                  //     final to = Duration(milliseconds: newValue.floor());
                  //     _visibleValue = to;
                  //   });
                  // },
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //         width: 40,
        //         child: Text(durationToString(widget.currentPosition),
        //             style: TextStyle(fontFamily: BitsFont.segoeItalicFont)),
        //       ),
        //       SizedBox(
        //         width: 200,
        //       ),
        //       SizedBox(
        //         width: 40,
        //         child: Text(
        //           durationToString(widget.duration),
        //           style: TextStyle(fontFamily: BitsFont.segoeItalicFont),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

// String durationToString(Duration duration) {
//   String twoDigits(int n) {
//     if (n >= 10) return '$n';
//     return '0$n';
//   }

//   final twoDigitMinutes =
//       twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
//   final twoDigitSeconds =
//       twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
//   return '$twoDigitMinutes:$twoDigitSeconds';
// }
