import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bits_project/core/values/config.dart';
import 'package:flutter/material.dart';

class ProgressSeekWidget extends StatelessWidget {
  final Duration progress;
  final Duration total;
  final Duration buffered;
  final Function(Duration) onSeek;
  final double shadowHeight;
  final double shadowWidth;
  final double width;
  final double height;

  const ProgressSeekWidget({
    super.key,
    required this.buffered,
    required this.total,
    required this.progress,
    required this.shadowHeight,
    required this.shadowWidth,
    required this.height,
    required this.width,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: shadowHeight,
                width: shadowWidth,
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
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
                child: ProgressBar(
                  timeLabelTextStyle: const TextStyle(
                      fontFamily: BitsFont.segoeItalicFont,
                      color: Colors.black),
                  timeLabelPadding: 10,
                  barHeight: 12,
                  bufferedBarColor: const Color.fromARGB(255, 202, 206, 255),
                  progressBarColor: const Color.fromARGB(255, 187, 194, 250),
                  baseBarColor: const Color.fromARGB(255, 216, 216, 250),
                  thumbColor: const Color.fromARGB(255, 210, 213, 246),
                  progress: progress,
                  total: total,
                  buffered: buffered,
                  onSeek: onSeek,
                ),
              )
              // SliderTheme(
              //     data: SliderThemeData(
              //       overlayColor: Colors.transparent,
              //       trackHeight: height,
              //       activeTrackColor: const Color.fromARGB(255, 201, 206, 255),
              //       trackShape: const RoundedRectSliderTrackShape(),
              //       inactiveTrackColor:
              //           const Color.fromARGB(255, 216, 216, 250),
              //       thumbShape: const PolygonSliderThumb(thumbRadius: 10.0),
              //       thumbColor: const Color.fromARGB(255, 210, 213, 246),
              //     ),
              //     child: ProgressBar(
              //       barHeight: 10,
              //       progressBarColor: const Color.fromARGB(255, 201, 206, 255),
              //       baseBarColor: const Color.fromARGB(255, 216, 216, 250),
              //       thumbColor: const Color.fromARGB(255, 210, 213, 246),
              //       progress: progress,
              //       total: total,
              //       buffered: buffered,
              //       onSeek: onSeek,
              //     )
              //     // child: Slider(
              //     //   min: 0,
              //     //   max: widget.duration,
              //     //   value: widget.currentPosition,
              //     //   onChanged: widget.onChanged,

              //     // ),
              //     ),
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
