import 'package:bits_project/features/data/repositories/audio_repository_impl.dart';
import 'package:bits_project/features/domain/repositories/audio_repository.dart';
import 'package:bits_project/features/presentation/pages/player/audio_player_list.dart';
import 'package:bits_project/features/presentation/pages/player/audio_player_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import 'package:bits_project/features/presentation/injection_container.dart'
    as di;
import 'package:bits_project/features/presentation/injection_container.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../../core/values/gradients.dart';
import '../../widgets/buttons/text_button_main_list.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_playlist_tile.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_tile.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView>
    with SingleTickerProviderStateMixin {
  static const _genres = genres;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 10, 19),
        body: Stack(
          children: [
            //   Image(
            //   height: size.height,
            //   width: size.width,
            //   image: AssetImage('lib/images/back_3.png'),
            //   fit: BoxFit.fill,
            // ),
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 130,
                  toolbarHeight: 130,
                  collapsedHeight: 130,
                  elevation: 0.0,
                  backgroundColor: const Color.fromARGB(0, 247, 14, 14),
                  actions: [
                    Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.1 * widgetScalling!,
                                  top: size.height * 0.01 * widgetScalling),
                              child: Image.asset('assets/images/logo_app.png',
                                  fit: BoxFit.fill,
                                  width: size.width * 0.2 * widgetScalling,
                                  height: size.height * 0.1 * widgetScalling),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.1 * widgetScalling),
                              child: Container(
                                height: size.height * 0.03 * widgetScalling,
                                width: size.width * 0.43 * widgetScalling,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 0, 247, 255))),
                                child: MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      textScaleFactor: 1.0 * textScale!),
                                  child: TextFormField(
                                    cursorWidth: 1.0,
                                    cursorColor:
                                        const Color.fromARGB(255, 236, 39, 243),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 247, 255),
                                        fontFamily: BitsFont.segoeItalicFont),
                                    decoration: InputDecoration(
                                      focusColor: Colors.transparent,
                                      hintText: 'Search...',
                                      hintStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 247, 255),
                                          fontFamily: BitsFont.spaceMono),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.height *
                                              0.12 *
                                              textFormScale!,
                                          horizontal:
                                              size.width * 0.3 * textFormScale),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      size.width * 0.03 * widgetScalling),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const UserPage()),
                                  // );
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(color: Colors.white)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.12 * widgetScalling),
                          child: SizedBox(
                            height: size.height * 0.05,
                            width: size.width,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemCount: textButtons.length,
                              itemBuilder: (context, index) {
                                return TextButtonHome(
                                  height: 0,
                                  width: 100,
                                  text: textButtons[index],
                                  fontSize: 1.5 * textScale,
                                  shader: listGradient[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _genres.length,
                    itemBuilder: (context, index) {
                      if (index == 1) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      size.width * 0.03 * widgetScalling!),
                              child: Text(
                                textParts[1],
                                // audio.genre!,
                                textScaleFactor: 2.0 * textScale!,
                                style: TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                        blurRadius: 5.0,
                                        offset: const Offset(0, 0),
                                        color: TextGradients.gradientColors[1]),
                                  ],
                                  foreground: Paint()
                                    ..shader = TextGradients.shaderList[1],
                                  fontFamily: BitsFont.spaceMono,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      size.width * 0.03 * widgetScalling),
                              child: SizedBox(
                                height: size.height * 0.003 * widgetScalling,
                                width: size.width * 0.35 * widgetScalling,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          blurRadius: 5.0,
                                          offset: const Offset(1, 1),
                                          color:
                                              TextGradients.gradientColors[1])
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: TextGradients
                                            .dividerGradientList[1]),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.02 * widgetScalling),
                              child: SizedBox(
                                height: size.height * 0.28 * widgetScalling,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _genres.length,
                                  itemBuilder: (context, itemIndex) {
                                    return ChangeNotifierProvider<
                                            AudioRepository>(
                                        create: (context) =>
                                            AudioRepositoryImpl(
                                                remoteDataSource: sl(),
                                                networkInfo: sl()),
                                        child: VinylPlayList(
                                            genreKey: _genres[itemIndex],
                                            index: itemIndex),
                                        builder: (context, child) {
                                          return child!;
                                        });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return ChangeNotifierProvider<AudioRepository>(
                            create: (context) => AudioRepositoryImpl(
                                remoteDataSource: sl(), networkInfo: sl()),
                            child: GenreList(
                              genreKey: _genres[index],
                              index: index,
                            ),
                            builder: (context, child) {
                              return child!;
                            });
                      }
                    }),
              ),
            )
          ],
        ));
  }
}

class GenreList extends StatefulWidget {
  final String genreKey;
  final int index;
  const GenreList({super.key, required this.genreKey, required this.index});

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  late AudioRepository _provider;

  @override
  void initState() {
    _provider = Provider.of<AudioRepository>(context, listen: false);
    _provider.getAudio(genre: widget.genreKey);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);

    Size size = MediaQuery.of(context).size;
    return Consumer<AudioRepository>(builder: (context, value, child) {
      if (value.isLoadingData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (value.audioItem == null || value.audioItem!.isEmpty) {
        return const Text('Error!');
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03 * widgetScalling!),
            child: Text(
              textParts[widget.index],
              // audio.genre!,
              textScaleFactor: 2.0 * textScale!,
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                      blurRadius: 5.0,
                      offset: const Offset(0, 0),
                      color: TextGradients.gradientColors[widget.index]),
                ],
                foreground: Paint()
                  ..shader = TextGradients.shaderList[widget.index],
                fontFamily: BitsFont.spaceMono,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03 * widgetScalling),
            child: SizedBox(
              height: size.height * 0.003 * widgetScalling,
              width: size.width * 0.35 * widgetScalling,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 5.0,
                        offset: const Offset(1, 1),
                        color: TextGradients.gradientColors[widget.index])
                  ],
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: TextGradients.dividerGradientList[widget.index]),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: SizedBox(
              height: size.height * 0.44 * widgetScalling,
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 2.0,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    value.audioItem!.length < 5 ? value.audioItem!.length : 4,
                    (index) {
                  return VinylAudioTileWidget(
                    vinylName: value.audioItem![index].audioName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AudioPlayerPage(
                                  index: index,
                                  // index: index,
                                  audioList: value.audioItem,
                                  // audioLink:
                                  //     value.audioItem![
                                  //             index][
                                  //         'audioLink'],
                                  // imageLink:
                                  //     value.audioItem![
                                  //             index][
                                  //         'imageLink'],
                                  // audioName:
                                  //     value.audioItem![
                                  //             index][
                                  //         'audioName'],
                                )),
                      );
                    },
                    author: value.audioItem![index].login,
                    mainImage: value.audioItem![index].imageLink,
                    vinylImage: value.audioItem![index].imageLink,
                  );
                }),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class VinylPlayList extends StatefulWidget {
  final String genreKey;
  final int index;
  const VinylPlayList({super.key, required this.genreKey, required this.index});

  @override
  State<VinylPlayList> createState() => _VinylPlayListState();
}

class _VinylPlayListState extends State<VinylPlayList> {
  late AudioRepository _provider;
  @override
  void initState() {
    _provider = Provider.of<AudioRepository>(context, listen: false);
    _provider.getAudio(genre: widget.genreKey);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);

    Size size = MediaQuery.of(context).size;
    return Consumer<AudioRepository>(builder: (context, value, child) {
      if (value.isLoadingData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (value.audioItem == null || value.audioItem!.isEmpty) {
        return const Text('Error!');
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //       horizontal: size.width * 0.03 * widgetScalling!),
          //   child: Text(
          //     textParts[widget.index],
          //     // audio.genre!,
          //     textScaleFactor: 2.0 * textScale!,
          //     style: TextStyle(
          //       shadows: <Shadow>[
          //         Shadow(
          //             blurRadius: 5.0,
          //             offset: const Offset(0, 0),
          //             color: TextGradients.gradientColors[widget.index]),
          //       ],
          //       foreground: Paint()
          //         ..shader = TextGradients.shaderList[widget.index],
          //       fontFamily: BitsFont.spaceMono,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //       horizontal: size.width * 0.03 * widgetScalling),
          //   child: SizedBox(
          //     height: size.height * 0.003 * widgetScalling,
          //     width: size.width * 0.35 * widgetScalling,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         boxShadow: <BoxShadow>[
          //           BoxShadow(
          //               blurRadius: 5.0,
          //               offset: const Offset(1, 1),
          //               color: TextGradients.gradientColors[widget.index])
          //         ],
          //         borderRadius: BorderRadius.circular(30),
          //         gradient: LinearGradient(
          //             begin: Alignment.centerLeft,
          //             end: Alignment.centerRight,
          //             colors: TextGradients.dividerGradientList[widget.index]),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: SizedBox(
                height: size.height * 0.44 * widgetScalling!,
                child: VinylPlaylistTile(
                  vinylName: value.audioItem![0].audioName,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioPlayerListPage(
                                // index: index,
                                audioList: value.audioItem,
                                // audioLink:
                                //     value.audioItem![
                                //             index][
                                //         'audioLink'],
                                // imageLink:
                                //     value.audioItem![
                                //             index][
                                //         'imageLink'],
                                // audioName:
                                //     value.audioItem![
                                //             index][
                                //         'audioName'],
                              )),
                    );
                  },
                  author: value.audioItem![0].login,
                  mainImage: value.audioItem![0].imageLink,
                  vinylImage: value.audioItem![0].imageLink,
                )),
          ),
        ],
      );
    });
  }
}
