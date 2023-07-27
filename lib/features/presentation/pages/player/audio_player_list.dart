import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bits_project/core/values/config.dart';
import 'package:bits_project/features/presentation/widgets/buttons/neumorph_button.dart';
import 'package:bits_project/features/presentation/widgets/vinyl_widgets/vinyl_widget.dart';
import 'package:bits_project/features/presentation/widgets/vinyl_widgets/vinyl_widget_audio.dart';
import 'package:flutter/material.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/models/audio_model.dart';
import '../../widgets/buttons/neumorph_icon_button.dart';
import '../../widgets/seek_widget/seek_bar.dart';

class AudioPlayerListPage extends StatefulWidget {
  final List<AudioModel>? audioList;
  const AudioPlayerListPage({super.key, this.audioList});

  @override
  State<AudioPlayerListPage> createState() => _AudioPlayerListPageState();
}

class _AudioPlayerListPageState extends State<AudioPlayerListPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  int audioIndex = 0;
  int indexPrev = 0;
  bool isPlaying = false;
  bool isRandom = false;
  int? _selectedIndex = 0;
  List<int> previosAudioList = [];
  final random = Random();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // isPlaying = isPlaying;
    audioIndex = audioIndex;
    String audio = widget.audioList![audioIndex].audioLink!;
    print(audio);
    audioPlayer.setSourceUrl('${getApiURl()}/$audio');
    // AudioPlayer.global.setAudioContext(audioContext);
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
    // audioPlayer.setSourceUrl('${getApiURl()}/$audio');
    //audioPlayer.setSourceUrl('http://192.168.137.1:3000/${widget.audioLink}');
    // setAudio();
    // audioPlayer.onPlayerStateChanged.listen((state) {
    //   audioPlayer.setVolume(1);
    //   isPlaying = state == PlayerState.playing;
    // });
    // audioPlayer.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });
    // audioPlayer.onPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });
    super.initState();
  }

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

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 214, 253),
      appBar: AppBar(
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Album of ${widget.audioList![audioIndex].genre} music',
          textScaleFactor: 12.0 * textFormScale!,
          style: const TextStyle(
              color: Colors.black, fontFamily: BitsFont.bitsFont),
        ),
        toolbarHeight: size.height * 0.08 * widgetScalling!,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 20, 20, 20),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.5 * widgetScalling,
              // height: size.height * widgetScalling * 0.42,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.audioList!.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.audioList!.length) {
                    return Container(
                      color: const Color.fromARGB(255, 225, 226, 247),
                      height: 50,
                    );
                  }
                  if (index < widget.audioList!.length) {
                    return GestureDetector(
                      onTap: () async {
                        _onSelected(index);
                        setState(() {
                          audioIndex = index;
                          isPlaying = true;
                        });
                        await audioPlayer.setSourceUrl(
                            '${getApiURl()}/${widget.audioList![audioIndex].audioLink}');
                        audioPlayer.resume();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 1.0,
                        ),
                        child: Container(
                          color:
                              _selectedIndex != null && _selectedIndex == index
                                  ? const Color.fromARGB(255, 198, 201, 255)
                                  : const Color.fromARGB(255, 225, 226, 247),
                          width: double.infinity,
                          height: size.height * 0.08,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Image.network(
                                        '${getApiURl()}/${widget.audioList![index].imageLink}',
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.audioList![index].login!,
                                          style: const TextStyle(
                                              fontFamily:
                                                  BitsFont.segoeItalicFont),
                                        ),
                                        Text(
                                          widget.audioList![index].audioName!,
                                          style: const TextStyle(
                                              fontFamily:
                                                  BitsFont.segoeItalicFont),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(Icons.more_vert_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: size.height * 0.43 * widgetScalling),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 196, 197, 250),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.0))),
                width: double.infinity,
                height: size.height * widgetScalling * 0.38,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Image.network(
                        //     '${getApiURl()}/${widget.audioList![audioIndex].imageLink}',
                        //     height: 50,
                        //     width: 50),
                        // NeumorphButton(
                        //   30.0,
                        //   text: "Play",
                        //   height: 40,
                        //   width: 40,
                        //   onTap: () {
                        //     // await audioPlayer.setSourceUrl(
                        //     //     '${getApiURl()}/${widget.audioList![audioIndex].audioLink}');
                        //     // audioPlayer.stop();
                        //   },
                        // )
                        VinylAudioWidget(
                            isAnimated: isPlaying,
                            mainImage: widget.audioList![audioIndex].imageLink!,
                            vinylImage:
                                widget.audioList![audioIndex].imageLink!),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.02 * widgetScalling,
                              left: size.width * 0.12 * widgetScalling),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.audioList![audioIndex].login}',
                                style: const TextStyle(
                                    fontFamily: BitsFont.segoeItalicFont),
                              ),
                              Text('${widget.audioList![audioIndex].audioName}',
                                  style: const TextStyle(
                                      fontFamily: BitsFont.segoeItalicFont)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02 * widgetScalling,
                    ),
                    SeekWidget(
                      shadowHeight: size.height * 0.02 * widgetScalling,
                      shadowWidth: size.width * 0.76 * widgetScalling,
                      height: size.height * 0.015 * widgetScalling,
                      width: size.width * 0.9 * widgetScalling,
                      duration: duration.inSeconds.toDouble(),
                      currentPosition: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
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
                        SizedBox(width: size.width * widgetScalling * 0.6),
                        Text(formatTime(duration - position),
                            style: const TextStyle(
                                fontFamily: BitsFont.segoeItalicFont))
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03 * widgetScalling,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: size.width * 0.08 * widgetScalling),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       NeumorphButton(
                    //         10.0,
                    //         fontFamily: BitsFont.segoeItalicFont,
                    //         textScaleFactor: 1.3 * textScale!,
                    //         height: size.height * 0.04 * widgetScalling,
                    //         width: size.width * 0.12 * widgetScalling,
                    //         onTap: () {
                    //           audioPlayer.seek(Duration(
                    //               seconds: position.inSeconds.toInt() - 5));
                    //         },
                    //         text: '-5',
                    //       ),
                    //       NeumorphButton(
                    //         10.0,
                    //         fontFamily: BitsFont.segoeItalicFont,
                    //         textScaleFactor: 1.5 * textScale,
                    //         height: size.height * 0.04 * widgetScalling,
                    //         width: size.width * 0.3 * widgetScalling,
                    //         onTap: () {},
                    //         text: 'Open lyrics',
                    //       ),
                    //       NeumorphButton(
                    //         10.0,
                    //         fontFamily: BitsFont.segoeItalicFont,
                    //         textScaleFactor: 1.3 * textScale,
                    //         height: size.height * 0.04 * widgetScalling,
                    //         width: size.width * 0.12 * widgetScalling,
                    //         onTap: () {
                    //           audioPlayer.seek(Duration(
                    //               seconds: position.inSeconds.toInt() + 5));
                    //         },
                    //         text: "+5",
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05 * widgetScalling),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NeumorphIconButton(
                            30.0,
                            icon: Icons.refresh,
                            width: size.width * 0.11 * widgetScalling,
                            height: size.height * 0.05 * widgetScalling,
                          ),
                          NeumorphIconButton(
                            30.0,
                            width: size.width * 0.11 * widgetScalling,
                            height: size.height * 0.05 * widgetScalling,
                            icon: Icons.skip_previous_outlined,
                            onTap: () async {
                              setState(() {
                                if (isRandom == false) {
                                  if (audioIndex >= 0) {
                                    audioIndex = audioIndex - 1;
                                  }
                                  if (audioIndex < 0) {
                                    audioIndex = widget.audioList!.length - 1;
                                  }
                                }
                                if (isRandom == true) {
                                  int randomNumber =
                                      random.nextInt(widget.audioList!.length);
                                  if (audioIndex >= 0) {
                                    indexPrev--;
                                    print(audioIndex);

                                    if (indexPrev > 0) {
                                      audioIndex = previosAudioList[indexPrev];
                                      previosAudioList.removeAt(indexPrev);
                                      print("Hello - " + audioIndex.toString());
                                    } else {
                                      audioIndex = 0;
                                    }
                                  }
                                  if (audioIndex < 0) {
                                    audioIndex = 0;
                                  }
                                }
                              });
                              await audioPlayer.setSourceUrl(
                                  '${getApiURl()}/${widget.audioList![audioIndex].audioLink}');
                              _onSelected(audioIndex);
                            },
                          ),
                          NeumorphIconButton(
                            30.0,
                            width: size.width * 0.13 * widgetScalling,
                            height: size.height * 0.06 * widgetScalling,
                            icon: isPlaying
                                ? Icons.pause_outlined
                                : Icons.play_arrow,
                            onTap: () => isPlaying ? pause() : play(),
                          ),
                          NeumorphIconButton(
                            30.0,
                            icon: Icons.skip_next_outlined,
                            width: size.width * 0.11 * widgetScalling,
                            height: size.height * 0.05 * widgetScalling,
                            onTap: () async {
                              setState(() {
                                if (isRandom == true) {
                                  setState(() {});
                                  int randomNumber =
                                      random.nextInt(widget.audioList!.length);

                                  if (audioIndex < widget.audioList!.length) {
                                    audioIndex = randomNumber;
                                    indexPrev++;
                                    previosAudioList.add(audioIndex);
                                    print(previosAudioList);
                                    print(audioIndex);
                                    print("Bye - " + indexPrev.toString());
                                  }
                                  if (audioIndex >= widget.audioList!.length) {
                                    audioIndex = 0;
                                  }
                                } else {
                                  if (audioIndex < widget.audioList!.length) {
                                    audioIndex = audioIndex + 1;
                                    print(audioIndex);
                                  }
                                  if (audioIndex >= widget.audioList!.length) {
                                    audioIndex = 0;
                                  }
                                }
                              });
                              await audioPlayer.setSourceUrl(
                                  '${getApiURl()}/${widget.audioList![audioIndex].audioLink}');
                              _onSelected(audioIndex);
                            },
                          ),
                          NeumorphIconButton(
                            30.0,
                            icon: isRandom
                                ? Icons.shuffle_on_outlined
                                : Icons.shuffle_rounded,
                            width: size.width * 0.11 * widgetScalling,
                            height: size.height * 0.05 * widgetScalling,
                            onTap: () async {
                              setState(() {
                                if (isRandom == true) {
                                  isRandom = false;
                                } else {
                                  isRandom = true;
                                }
                              });
                              await audioPlayer.setSourceUrl(
                                  '${getApiURl()}/${widget.audioList![audioIndex].audioLink}');
                              _onSelected(audioIndex);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
