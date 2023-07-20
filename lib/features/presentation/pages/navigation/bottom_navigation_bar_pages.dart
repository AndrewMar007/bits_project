import 'package:bits_project/features/presentation/pages/navigation/upload_audio_page.dart';
import 'package:flutter/material.dart';
import 'package:bits_project/features/presentation/pages/navigation/playlist_view.dart';

class BottomBarMenu extends StatefulWidget {
  const BottomBarMenu({super.key});

  @override
  State<BottomBarMenu> createState() => _BottomBarMenuState();
}

// BottomNavigationBarItem getItem() {
//   return BottomNavigationBarItem(
//       icon: Container(
//         decoration: const BoxDecoration(
//           color: Colors.black,
//           shape: BoxShape.circle,
//         ),
//         height: 56,
//         width: 56,
//         child: const Icon(Icons.favorite),
//       ),
//       label: '');
// }

final menuButtonList = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.home,
    ),
    label: 'Home',
    activeIcon: Icon(
      Icons.home,
      shadows: [
        Shadow(color: Color.fromARGB(255, 225, 78, 245), blurRadius: 20.0)
      ],
    ),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.music_note),
    label: 'Upload',
    activeIcon: Icon(
      Icons.music_note,
      shadows: [
        Shadow(color: Color.fromARGB(255, 225, 78, 245), blurRadius: 20.0)
      ],
    ),
  ),
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.assistant_navigation,
    ),
    activeIcon: Icon(
      Icons.assistant_navigation,
      shadows: [
        Shadow(color: Color.fromARGB(255, 225, 78, 245), blurRadius: 20.0)
      ],
    ),
    label: 'Navigate',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.library_books),
    label: 'Library',
    activeIcon: Icon(
      Icons.library_books,
      shadows: [
        Shadow(color: Color.fromARGB(255, 225, 78, 245), blurRadius: 20.0)
      ],
    ),
  ),
];
int index = 0;
final pageList = <Widget>[
  const PlaylistView(),
  const UploadAudioPage(),
];

//MainAudioPageList()
class _BottomBarMenuState extends State<BottomBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            canvasColor: const Color.fromARGB(255, 20, 9, 26)),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black, blurRadius: 20)
              ]),
              child: BottomNavigationBar(
                  selectedLabelStyle: const TextStyle(shadows: [
                    Shadow(
                        color: Color.fromARGB(255, 225, 78, 245),
                        blurRadius: 10.0,
                        offset: Offset(1, 1))
                  ]),
                  iconSize: 20.0,
                  selectedFontSize: 11.0,
                  unselectedFontSize: 9.0,
                  currentIndex: index,
                  onTap: (bottomIndex) {
                    setState(() {
                      index = bottomIndex;
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: const Color.fromARGB(255, 246, 63, 225),
                  showUnselectedLabels: true,
                  selectedItemColor: const Color.fromARGB(255, 210, 16, 184),
                  items: menuButtonList),
            ),
          ],
        ),
      ),
      body: IndexedStack(index: index, children: pageList),
    );
  }
}
