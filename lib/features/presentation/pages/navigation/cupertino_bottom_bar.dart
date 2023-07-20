import 'package:bits_project/features/presentation/pages/navigation/playlist_view.dart';
import 'package:bits_project/features/presentation/pages/navigation/upload_audio_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/values/device_platform_scale.dart';

class CupertinoBottomBar extends StatelessWidget {
  const CupertinoBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    Size size = MediaQuery.of(context).size;
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          height: size.height * widgetScalling! * 0.065,
          backgroundColor: const Color.fromARGB(255, 20, 9, 26),
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
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(child: PlaylistView());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(child: UploadAudioPage());
                },
              );
            default:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(child: PlaylistView());
                },
              );
          }
        }));
  }
}
