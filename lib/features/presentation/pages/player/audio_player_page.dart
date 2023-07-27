import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bits_project/features/data/models/audio_model.dart';

import 'package:flutter/material.dart';

import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/buttons/neumorph_icon_button.dart';
import '../../widgets/play_back.dart';
import '../../widgets/seek_widget/seek_bar.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_audio.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_player.dart';

class AudioPlayerPage extends StatefulWidget {
  List<AudioModel>? audioList;
  int? index;
  // String? audioLink;
  // String? audioName;
  // String? imageLink;
  AudioPlayerPage(
      {this.audioList,
      this.index,
      // this.audioLink,
      // this.audioName,
      // this.imageLink,
      super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with TickerProviderStateMixin {
  // late final AnimationController _controller = AnimationController(
  //   vsync: this,
  // );

  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.linear,
  // );
  int indexPrev = 0;
  bool isAnimated = false;
  bool isPlaying = false;
  bool isRandom = false;
  final random = Random();
  List<int> previosAudioList = [];
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    String audio = widget.audioList![widget.index!].audioLink!;
    print(audio);
    audioPlayer.setSourceUrl('${getApiURl()}/$audio');
    // AudioPlayer.global.setGlobalAudioContext(audioContext);
    //audioPlayer.setSourceUrl('http://192.168.137.1:3000/${widget.audioLink}');
    // setAudio();

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
    // audioPlayer.open(Audio('assets/audios/vitaminD.mp3'),
    //     autoStart: false, showNotification: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;
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

    Future play() async {
      await audioPlayer.resume();
      setState(() {
        isPlaying = true;
      });
    }

    Future pause() async {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 211, 214, 253),
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
                    AppBar(
                      automaticallyImplyLeading: false,
                      // leading: GestureDetector(
                      //   child: Icon(
                      //     Icons.arrow_back_ios_new,
                      //     color: Colors.black,
                      //     size: size.height * 0.025 * widgetScalling!,
                      //   ),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      centerTitle: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                              size: size.height * 0.025 * widgetScalling!,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Beat.Flex',
                            textScaleFactor: 12.0 * textFormScale!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: BitsFont.bitsFont),
                          ),
                          NeumorphIconButton(
                            30.0,
                            icon: Icons.menu_open,
                            width: size.width * 0.1 * widgetScalling,
                            height: size.height * 0.05 * widgetScalling,
                          ),
                        ],
                      ),
                      toolbarHeight: size.height * 0.08 * widgetScalling,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       width: size.width * 0.2 * widgetScalling!,
                    //     ),
                    //     Text(
                    //       'Beat.Flex',
                    //       textScaleFactor: 18.0 * textFormScale!,
                    //       style: TextStyle(fontFamily: BitsFont.bitsFont),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           vertical: size.height * 0.03 * widgetScalling!,
                    //           horizontal: size.width * 0.06 * widgetScalling),
                    //       child: CircleAssetButton(
                    //         'lib/images/more.png',
                    //         imageHeight: size.height * 0.08 * widgetScalling,
                    //         imageWidth: size.width * 0.08 * widgetScalling,
                    //         width: size.width * 0.1 * widgetScalling,
                    //         height: size.height * 0.05 * widgetScalling,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              VinylAudioPlayerWidget(
                                isAnimated: isPlaying,
                                mainImage:
                                    widget.audioList![widget.index!].imageLink!,
                                vinylImage:
                                    widget.audioList![widget.index!].imageLink!,
                              ),
                              SizedBox(
                                  height: size.height * 0.05 * widgetScalling),
                              PlayBack(
                                height: size.height * 0.05 * widgetScalling,
                                width: size.width * 0.6 * widgetScalling,
                                child: Center(
                                    child: Text(
                                  widget.audioList![widget.index!].audioName!,
                                  textScaleFactor: 1.5 * textScale!,
                                  style: const TextStyle(
                                      fontFamily: BitsFont.segoeItalicFont),
                                )),
                              ),
                              SizedBox(
                                  height: size.height * 0.05 * widgetScalling),
                              SeekWidget(
                                shadowHeight:
                                    size.height * 0.02 * widgetScalling,
                                shadowWidth: size.width * 0.76 * widgetScalling,
                                height: size.height * 0.015 * widgetScalling,
                                width: size.width * 0.9 * widgetScalling,
                                duration: duration.inSeconds.toDouble(),
                                currentPosition: position.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  final position =
                                      Duration(seconds: value.toInt());
                                  await audioPlayer.seek(position);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formatTime(position),
                                    style: const TextStyle(
                                        fontFamily: BitsFont.segoeItalicFont),
                                  ),
                                  SizedBox(
                                      width: size.width * widgetScalling * 0.6),
                                  Text(formatTime(duration - position),
                                      style: const TextStyle(
                                          fontFamily: BitsFont.segoeItalicFont))
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.05 * widgetScalling,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeumorphButton(
                                    10.0,
                                    fontFamily: BitsFont.segoeItalicFont,
                                    textScaleFactor: 1.5 * textScale,
                                    height: size.height * 0.05 * widgetScalling,
                                    width: size.width * 0.15 * widgetScalling,
                                    onTap: () {
                                      audioPlayer.seek(Duration(
                                          seconds:
                                              position.inSeconds.toInt() - 5));
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
                                      audioPlayer.seek(Duration(
                                          seconds:
                                              position.inSeconds.toInt() + 5));
                                    },
                                    text: "+5",
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.05 * widgetScalling),
                          PlayBack(
                            height: size.height * 0.12 * widgetScalling,
                            width: size.width * 0.9 * widgetScalling,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: size.width * 0.03 * widgetScalling,
                                ),
                                NeumorphIconButton(
                                  30.0,
                                  icon: Icons.refresh,
                                  width: size.width * 0.1 * widgetScalling,
                                  height: size.height * 0.05 * widgetScalling,
                                ),

                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),
                                NeumorphIconButton(
                                  30.0,
                                  icon: Icons.skip_previous,
                                  width: size.width * 0.12 * widgetScalling,
                                  height: size.height * 0.06 * widgetScalling,
                                  onTap: () async {
                                    setState(() {
                                      if (isRandom == false) {
                                        if (widget.index! >= 0) {
                                          widget.index = widget.index! - 1;
                                        }
                                        if (widget.index! < 0) {
                                          widget.index =
                                              widget.audioList!.length - 1;
                                        }
                                      }
                                      if (isRandom == true) {
                                        int randomNumber = random
                                            .nextInt(widget.audioList!.length);
                                        if (widget.index! >= 0) {
                                          indexPrev--;
                                          print(widget.index!);

                                          if (indexPrev > 0) {
                                            widget.index =
                                                previosAudioList[indexPrev];
                                            previosAudioList
                                                .removeAt(indexPrev);
                                            print("Hello - " +
                                                widget.index!.toString());
                                          } else {
                                            widget.index = 0;
                                          }
                                        }
                                        if (widget.index! < 0) {
                                          widget.index = 0;
                                        }
                                      }
                                    });
                                    await audioPlayer.setSourceUrl(
                                        '${getApiURl()}/${widget.audioList![widget.index!].audioLink}');
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),

                                NeumorphIconButton(
                                  30.0,
                                  icon: isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  height: size.height * 0.07 * widgetScalling,
                                  width: size.width * 0.15 * widgetScalling,
                                  onTap: () => isPlaying ? pause() : play(),
                                ),
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
                                NeumorphIconButton(
                                  30.0,
                                  icon: Icons.skip_next,
                                  width: size.width * 0.12 * widgetScalling,
                                  height: size.height * 0.06 * widgetScalling,
                                  onTap: () async {
                                    setState(() {
                                      if (isRandom == true) {
                                        setState(() {});
                                        int randomNumber = random
                                            .nextInt(widget.audioList!.length);

                                        if (widget.index! <
                                            widget.audioList!.length) {
                                          widget.index = randomNumber;
                                          indexPrev++;
                                          previosAudioList.add(widget.index!);
                                          print(previosAudioList);
                                          print(widget.index!);
                                          print(
                                              "Bye - " + indexPrev.toString());
                                        }
                                        if (widget.index! >=
                                            widget.audioList!.length) {
                                          widget.index = 0;
                                        }
                                      } else {
                                        if (widget.index! <
                                            widget.audioList!.length) {
                                          widget.index = widget.index! + 1;
                                          print(widget.index!);
                                        }
                                        if (widget.index! >=
                                            widget.audioList!.length) {
                                          widget.index = 0;
                                        }
                                      }
                                    });
                                    await audioPlayer.setSourceUrl(
                                        '${getApiURl()}/${widget.audioList![widget.index!].audioLink}');
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.01 * widgetScalling,
                                ),
                                NeumorphIconButton(
                                  30.0,
                                  icon: isRandom
                                      ? Icons.shuffle_on_rounded
                                      : Icons.shuffle_rounded,
                                  width: size.width * 0.1 * widgetScalling,
                                  height: size.height * 0.05 * widgetScalling,
                                  onTap: () {
                                    if (isRandom == true) {
                                      setState(() {
                                        isRandom = false;
                                      });
                                    } else {
                                      setState(() {
                                        isRandom = true;
                                      });
                                    }
                                    print(isRandom);
                                  },
                                ),
                                SizedBox(
                                  width: size.width * 0.03 * widgetScalling,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  // Future setAudio() async {
  //   String url = 'http://192.168.137.1:3000/monatik.mp3';
  //   await audioPlayer.setSourceUrl('http://192.168.137.1:3000/monatik.wav');
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    //_controller.dispose();

    audioPlayer.dispose();
    super.dispose();
  }
}
