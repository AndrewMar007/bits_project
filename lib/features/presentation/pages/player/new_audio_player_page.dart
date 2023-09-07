import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bits_project/core/values/page_manager.dart';
import 'package:bits_project/features/presentation/provider/audio_provider.dart';
import 'package:bits_project/features/presentation/provider/notifiers/image_notifier.dart';
import 'package:bits_project/features/presentation/provider/notifiers/play_button_notifier.dart';
import 'package:bits_project/features/presentation/provider/notifiers/progress_notifier.dart';
import 'package:bits_project/features/presentation/provider/notifiers/repeat_button_notifier.dart';
import 'package:bits_project/features/presentation/widgets/seek_widget/progress_seek_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/buttons/neumorph_icon_button.dart';
import '../../widgets/play_back.dart';
import '../../widgets/seek_widget/seek_bar.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_player.dart';
import '../../injection_container.dart' as di;

// ignore: must_be_immutable
class NewAudioPlayerPage extends StatefulWidget {
  final List<AudioModel>? audioList;
  int? index;
  final OverlayEntry entry;
  // String? audioLink;
  // String? audioName;
  // String? imageLink;
  NewAudioPlayerPage(
      {super.key, this.audioList, this.index, required this.entry});

  @override
  State<NewAudioPlayerPage> createState() => _NewAudioPlayerPageState();
}

class _NewAudioPlayerPageState extends State<NewAudioPlayerPage>
    with SingleTickerProviderStateMixin {
  int indexPrev = 0;
  bool isAnimated = false;
  bool isPlaying = false;
  bool isRandom = false;
  final random = Random();
  List<int> previosAudioList = [];
  // AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late AnimationController _pagePlayerController;
  final _duration = const Duration(seconds: 2);
  late AudioProvider _audioProvider;

  @override
  void initState() {
    super.initState();
    di.sl<PageManager>().init();
    di.sl<PageManager>().setAudioList(widget.audioList!);
    _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    _pagePlayerController =
        AnimationController(vsync: this, duration: _duration);
    // String audio = widget.audioList![widget.index!].audioLink!;
    // audioPlayer.setSourceUrl('${getApiURl()}/$audio');

    // audioPlayer.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });
    // audioPlayer.onPositionChanged.listen((newPosition) {
    //   if (mounted) {
    //     setState(() {
    //       position = newPosition;
    //     });
    //   }
    // });
    // audioPlayer.open(Audio('assets/audios/vitaminD.mp3'),
    //     autoStart: false, showNotification: true);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _widgetScalling = scaleSmallDevice(context);
  //   _textScale = textScaleRatio(context);
  //   _textFormScale = textFormTopRatio(context);
  //   _size = MediaQuery.of(context).size;
  // }

  @override
  void didUpdateWidget(covariant NewAudioPlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _pagePlayerController.duration = _duration;
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;
    final pageManager = di.sl<PageManager>();

    String formatTime(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return [
        if (duration.inHours > 0) hours,
        minutes,
        seconds,
      ].join(':');
    }

    // Future play() async {
    //   await audioPlayer.resume();
    //   setState(() {
    //     isPlaying = true;
    //   });
    // }

    // Future pause() async {
    //   await audioPlayer.pause();
    //   setState(() {
    //     isPlaying = false;
    //   });
    // }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 214, 253),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: AppBarWidget(
            size: size,
            widgetScalling: widgetScalling,
            widget: widget,
            textFormScale: textFormScale),
        toolbarHeight: size.height * 0.08 * widgetScalling,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(

                //     gradient: LinearGradient(colors: [
                //   const Color.fromARGB(255, 255, 44, 192).withOpacity(0.4),
                //   const Color.fromARGB(255, 15, 247, 255).withOpacity(0.4)
                // ])),
                ),
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * widgetScalling * 0.1,
                            ),
                            child: ValueListenableBuilder<String>(
                                valueListenable:
                                    pageManager.currentSongImageNotifier,
                                builder: (_, image, __) {
                                  return VinylAudioPlayerWidget(
                                    isAnimated: isPlaying,
                                    mainImage: image,
                                    vinylImage: image,
                                  );
                                })),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * widgetScalling * 0.2,
                              vertical: size.height * widgetScalling * 0.34),
                          child: SongTitleWidget(
                              size: size,
                              widgetScalling: widgetScalling,
                              widget: widget,
                              textScale: textScale),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width * widgetScalling * 0.1,
                              left: size.width * widgetScalling * 0.1,
                              top: size.height * widgetScalling * 0.4),
                          child: ProgressBarWidget(
                            size: size,
                            widgetScalling: widgetScalling,
                            duration: duration,
                            position: position,
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       right: size.width * widgetScalling * 0.06,
                        //       left: size.width * widgetScalling * 0.06,
                        //       top: size.height * widgetScalling * 0.5),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         formatTime(position),
                        //         style: const TextStyle(
                        //             fontFamily: BitsFont.segoeItalicFont),
                        //       ),
                        //       SizedBox(
                        //           width: size.width * widgetScalling * 0.6),
                        //       Text(formatTime(duration - position),
                        //           style: const TextStyle(
                        //               fontFamily: BitsFont.segoeItalicFont))
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width * widgetScalling * 0.05,
                              left: size.width * widgetScalling * 0.05,
                              top: size.height * widgetScalling * 0.53),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NeumorphButton(
                                10.0,
                                fontFamily: BitsFont.segoeItalicFont,
                                textScaleFactor: 1.5 * textScale,
                                height: size.height * 0.05 * widgetScalling,
                                width: size.width * 0.15 * widgetScalling,
                                onTap: () {
                                  // audioPlayer.seek(Duration(
                                  //     seconds: position.inSeconds.toInt() - 5));
                                },
                                text: '-5',
                              ),
                              SizedBox(
                                width: size.width * 0.1 * widgetScalling,
                              ),
                              NeumorphButton(
                                10.0,
                                fontFamily: BitsFont.segoeItalicFont,
                                textScaleFactor: 1.5 * textScale,
                                height: size.height * 0.05 * widgetScalling,
                                width: size.width * 0.3 * widgetScalling,
                                onTap: () {},
                                text: 'Open lyrics',
                              ),
                              SizedBox(
                                width: size.width * 0.1 * widgetScalling,
                              ),
                              NeumorphButton(
                                10.0,
                                fontFamily: BitsFont.segoeItalicFont,
                                textScaleFactor: 1.5 * textScale,
                                height: size.height * 0.05 * widgetScalling,
                                width: size.width * 0.15 * widgetScalling,
                                onTap: () {
                                  // audioPlayer.seek(Duration(
                                  //     seconds: position.inSeconds.toInt() + 5));
                                },
                                text: "+5",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: size.width * widgetScalling * 0.05,
                              left: size.width * widgetScalling * 0.05,
                              top: size.height * widgetScalling * 0.63),
                          child: PlayBack(
                            height: size.height * 0.12 * widgetScalling,
                            width: size.width * 0.9 * widgetScalling,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: size.width * 0.03 * widgetScalling,
                                ),
                                ValueListenableBuilder<RepeatState>(
                                    valueListenable:
                                        pageManager.repeatButtonNotifier,
                                    builder: (context, value, child) {
                                      Icon icon;
                                      switch (value) {
                                        case RepeatState.off:
                                          icon = const Icon(
                                            Icons.repeat,
                                            color: Colors.grey,
                                          );
                                          break;
                                        case RepeatState.repeatSong:
                                          icon = const Icon(
                                            Icons.repeat_one,
                                            color: Colors.black,
                                          );
                                          break;
                                        case RepeatState.repeatPlaylist:
                                          icon = const Icon(
                                            Icons.repeat,
                                            color: Colors.black,
                                          );
                                          break;
                                      }
                                      return IconButton(
                                        icon: icon,
                                        onPressed: pageManager.repeat,
                                      );
                                    }),

                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),
                                ValueListenableBuilder<bool>(
                                    valueListenable:
                                        pageManager.isFirstSongNotifier,
                                    builder: (_, isFirst, __) {
                                      return NeumorphIconButton(30.0,
                                          icon: Icons.skip_next,
                                          width: size.width *
                                              0.12 *
                                              widgetScalling,
                                          height: size.height *
                                              0.06 *
                                              widgetScalling,
                                          onTap: (isFirst)
                                              ? null
                                              : pageManager.previous);
                                    }),
                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),

                                ValueListenableBuilder<ButtonState>(
                                    valueListenable:
                                        pageManager.playButtonNotifier,
                                    builder: (_, value, __) {
                                      switch (value) {
                                        case ButtonState.loading:
                                          return Container(
                                            margin: const EdgeInsets.all(8.0),
                                            width: 32.0,
                                            height: 32.0,
                                            child:
                                                const CircularProgressIndicator(),
                                          );
                                        case ButtonState.paused:
                                          return NeumorphIconButton(
                                            30.0,
                                            icon: Icons.play_arrow,
                                            height: size.height *
                                                0.07 *
                                                widgetScalling,
                                            width: size.width *
                                                0.15 *
                                                widgetScalling,
                                            onTap: () => pageManager.play(),
                                          );
                                        case ButtonState.playing:
                                          return NeumorphIconButton(
                                            30.0,
                                            icon: Icons.pause,
                                            height: size.height *
                                                0.07 *
                                                widgetScalling,
                                            width: size.width *
                                                0.15 *
                                                widgetScalling,
                                            onTap: () => pageManager.pause(),
                                          );
                                      }
                                    }),
                                // CircleAssetButton(
                                //   'lib/images/play.png',
                                //   width: size.width * 0.2 * widgetScalling,
                                //   height: size.height * 0.09 * widgetScalling,
                                //   onTap: () {
                                //     AnimateVinyl();
                                //     // audioPlayer.play();
                                //     // audioPlayer.stop();
                                //   },
                                // ),
                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),
                                ValueListenableBuilder<bool>(
                                    valueListenable:
                                        pageManager.isLastSongNotifier,
                                    builder: (_, isLast, __) {
                                      return NeumorphIconButton(30.0,
                                          icon: Icons.skip_next,
                                          width: size.width *
                                              0.12 *
                                              widgetScalling,
                                          height: size.height *
                                              0.06 *
                                              widgetScalling,
                                          onTap: (isLast)
                                              ? null
                                              : pageManager.next);
                                    }),
                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),
                                ValueListenableBuilder<bool>(
                                    valueListenable: pageManager
                                        .isShuffleModeEnabledNotifier,
                                    builder: (context, isEnabled, child) {
                                      return IconButton(
                                        icon: (isEnabled)
                                            ? const Icon(Icons.shuffle_rounded)
                                            : const Icon(
                                                Icons.shuffle_rounded,
                                                color: Colors.grey,
                                              ),
                                        onPressed: pageManager.shuffle,
                                      );
                                    }),
                                SizedBox(
                                  width: size.width * 0.03 * widgetScalling,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  // Future setAudio() async {
  //   String url = 'http://192.168.137.1:3000/monatik.mp3';
  //   await audioPlayer.setSourceUrl('http://192.168.137.1:3000/monatik.wav');
  // }

  @override
  void dispose() {
    di.sl<PageManager>().dispose();
    //_controller.dispose();
    _pagePlayerController.dispose();
    super.dispose();
  }
}

// class VinylAudioWidget extends StatelessWidget {
//   const VinylAudioWidget({
//     super.key,
//     required this.isPlaying,
//     required this.widget,
//   });

//   final bool isPlaying;
//   final NewAudioPlayerPage widget;

//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return
//   }
// }

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.size,
    required this.widgetScalling,
    required this.duration,
    required this.position,
  });

  final Size size;
  final double widgetScalling;
  final Duration duration;
  final Duration position;

  @override
  Widget build(BuildContext context) {
    final pageManager = di.sl<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
        valueListenable: pageManager.progressNotifier,
        builder: (_, value, __) {
          return ProgressSeekWidget(
            shadowHeight: size.height * 0.02 * widgetScalling,
            shadowWidth: size.width * 0.76 * widgetScalling,
            height: size.height * 0.015 * widgetScalling,
            width: size.width * 0.9 * widgetScalling,
            progress: value.current,
            buffered: value.buffered,
            total: value.total,
            onSeek: pageManager.seek,
          );
        });
    // return SeekWidget(
    // shadowHeight: size.height * 0.02 * widgetScalling,
    // shadowWidth: size.width * 0.76 * widgetScalling,
    // height: size.height * 0.015 * widgetScalling,
    // width: size.width * 0.9 * widgetScalling,
    //   duration: duration.inSeconds.toDouble(),
    //   currentPosition: position.inSeconds.toDouble(),
    //   onChanged: (value) async {
    //     final position = Duration(seconds: value.toInt());
    //     await audioPlayer.seek(position);
    //   },
    // );
  }
}

class SongTitleWidget extends StatelessWidget {
  const SongTitleWidget({
    super.key,
    required this.size,
    required this.widgetScalling,
    required this.widget,
    required this.textScale,
  });

  final Size size;
  final double widgetScalling;
  final NewAudioPlayerPage widget;

  final double textScale;

  @override
  Widget build(BuildContext context) {
    final pageManager = di.sl<PageManager>();
    return ValueListenableBuilder<String>(
        valueListenable: pageManager.currentSongTitleNotifier,
        builder: (_, title, __) {
          return PlayBack(
            height: size.height * 0.05 * widgetScalling,
            width: size.width * 0.6 * widgetScalling,
            child: Center(
                child: Text(
              title,
              textScaleFactor: 1.5 * textScale,
              style: const TextStyle(fontFamily: BitsFont.segoeItalicFont),
            )),
          );
        });
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.size,
    required this.widgetScalling,
    required this.widget,
    required this.textFormScale,
  });

  final Size size;
  final double widgetScalling;
  final NewAudioPlayerPage widget;
  final double textFormScale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: size.height * 0.025 * widgetScalling,
          ),
          onTap: () {
            widget.entry.remove();
          },
        ),
        Text(
          'Beat.Flex',
          textScaleFactor: 12.0 * textFormScale,
          style: const TextStyle(
              color: Colors.black, fontFamily: BitsFont.bitsFont),
        ),
        NeumorphIconButton(
          30.0,
          icon: Icons.menu_open,
          width: size.width * 0.1 * widgetScalling,
          height: size.height * 0.05 * widgetScalling,
        ),
      ],
    );
  }
}
