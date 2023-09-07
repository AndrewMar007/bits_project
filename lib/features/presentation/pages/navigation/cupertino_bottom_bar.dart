import 'package:bits_project/core/values/page_manager.dart';
import 'package:bits_project/features/presentation/pages/navigation/playlist_view.dart';
import 'package:bits_project/features/presentation/pages/navigation/upload_audio_page.dart';
import 'package:bits_project/features/presentation/provider/audio_provider.dart';
import 'package:bits_project/features/presentation/route_generator.dart';
import 'package:bits_project/features/presentation/widgets/vinyl_widgets/vinyl_overlay_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/models/audio_model.dart';
import '../player/audio_player_page.dart';
import '../player/new_audio_player_page.dart';
import '../../injection_container.dart' as di;

class CupertinoBottomBar extends StatefulWidget {
  const CupertinoBottomBar({super.key});

  @override
  State<CupertinoBottomBar> createState() => CupertinoBottomBarState();
}

GlobalKey<CupertinoBottomBarState> keyGlobal = GlobalKey();

class CupertinoBottomBarState extends State<CupertinoBottomBar> {
  late double widgetScalling;
  late OverlayEntry entry;
  Offset offset = Offset(20, 40);
  double? _positionOfOverlay;
  double? horizontalPosition;
  double? height;
  double? width;
  double opacity = 1.0;
  double opacity1 = 1.0;
  bool isHideMainPAge = false;
  late int _audioProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widgetScalling = scaleSmallDevice(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _audioProvider = Provider.of<AudioProvider>(context).index;
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          height: size.height * widgetScalling * 0.065,
          backgroundColor: const Color.fromARGB(255, 33, 15, 43),
          iconSize: 20.0,
          activeColor: const Color.fromARGB(255, 210, 16, 184),
          inactiveColor: const Color.fromARGB(255, 246, 63, 225),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                shadows: [
                  Shadow(
                      color: Color.fromARGB(255, 225, 78, 245),
                      blurRadius: 20.0)
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Upload',
              activeIcon: Icon(
                Icons.music_note,
                shadows: [
                  Shadow(
                      color: Color.fromARGB(255, 225, 78, 245),
                      blurRadius: 20.0)
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assistant_navigation,
              ),
              activeIcon: Icon(
                Icons.assistant_navigation,
                shadows: [
                  Shadow(
                      color: Color.fromARGB(255, 225, 78, 245),
                      blurRadius: 20.0)
                ],
              ),
              label: 'Navigate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Library',
              activeIcon: Icon(
                Icons.library_books,
                shadows: [
                  Shadow(
                      color: Color.fromARGB(255, 225, 78, 245),
                      blurRadius: 20.0)
                ],
              ),
            ),
          ],
        ),
        tabBuilder: ((context, index) {
          switch (index) {
            case 0:
              return const PlaylistView();
            case 1:
              return const UploadAudioPage();
            default:
              return ErrorWidget("route error");
          }
          // switch (index) {
          //   case 0:
          //     return CupertinoTabView(
          //       onGenerateRoute: RouteGenerator.generateRoute,
          //       builder: (context) {
          //         return const CupertinoPageScaffold(child: PlaylistView());
          //       },
          //     );
          //   case 1:
          //     return CupertinoTabView(
          //       builder: (context) {
          //         return const CupertinoPageScaffold(child: UploadAudioPage());
          //       },
          //     );
          //   default:
          //     return CupertinoTabView(
          //       builder: (context) {
          //         return const CupertinoPageScaffold(child: PlaylistView());
          //       },
          //     );
          // }
        }));
  }

  // void createOverlay(BuildContext context, String text) {
  //   OverlayState overlayState = Overlay.of(context);
  //   entry = OverlayEntry(
  //     builder: (context) {
  //       return Positioned(
  //         left: 50,
  //         top: 100,
  //         child: Container(
  //           color: Colors.green,
  //           height: 100,
  //           width: 200,
  //           child: Text(
  //             text,
  //             style: TextStyle(color: Colors.red),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //   overlayState.insert(entry);
  // }
  void createOverlay(BuildContext context, Size size,
      List<AudioModel>? audioList, int index, double widgetScaling) {
    di.sl<PageManager>().setAudioList(audioList!);
    entry = OverlayEntry(builder: (context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: size.height * widgetScalling * 0.06),
          child: GestureDetector(
              onVerticalDragUpdate: (details) {
                index = _audioProvider;
                height = size.height - details.globalPosition.dy;
                // opacity = details.globalPosition.dy;
                print("Current index - " + index.toString());

                final position = details.globalPosition.dy / 600;
                if (1 > position && position > 0) {
                  setState(() {
                    opacity = opacity1 - details.globalPosition.dy / 600;
                  });
                } else if (position > 1 && opacity != 1) {
                  opacity = 0;
                } else if (position < 0 && opacity != 0) {
                  opacity = 1;
                }

                entry.markNeedsBuild();
                height! < size.height * widgetScalling * 0.07
                    ? height = size.height * widgetScalling * 0.07
                    : height!;
              },
              onVerticalDragEnd: (details) {
                if (height! < size.height * 0.5) {
                  opacity = 0.0;
                  entry.markNeedsBuild();
                  height = size.height * widgetScalling * 0.07;
                } else {
                  opacity = 1.0;
                  height = size.height;
                  entry.markNeedsBuild();
                }
              },
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    width: size.width,
                    child: VinylOverlayWidget(
                      index: index,
                      audioList: audioList,
                      vinylImage: audioList[index].imageLink!,
                      mainImage: audioList[index].imageLink!,
                    ),
                  ),
                  AnimatedOpacity(
                      duration: Duration(milliseconds: 1),
                      curve: Curves.bounceIn,
                      opacity: opacity,
                      child: Container(
                          height: height,
                          width: size.width,
                          child: NewAudioPlayerPage(
                            entry: entry,
                            audioList: audioList,
                            index: index,
                          ))),
                ],
              )),
        ),
      );
    });
    final overlay = Overlay.of(context);
    overlay.insert(entry);
  }
}
