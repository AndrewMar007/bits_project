import 'package:bits_project/features/presentation/bloc/audio_bloc/audio_bloc.dart';
import 'package:bits_project/features/presentation/bloc/audio_bloc/audio_state.dart';
import 'package:bits_project/features/presentation/pages/navigation/bottom_navigation_bar_pages.dart';
import 'package:bits_project/features/presentation/pages/navigation/cupertino_bottom_bar.dart';
import 'package:bits_project/features/presentation/pages/player/audio_player_list.dart';
import 'package:bits_project/features/presentation/pages/player/audio_player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import 'package:bits_project/features/presentation/injection_container.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../../core/values/gradients.dart';
import '../../../data/models/audio_model.dart';
import '../../bloc/audio_bloc/audio_event.dart';
import '../../provider/audio_provider.dart';
import '../../widgets/buttons/text_button_main_list.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_playlist_tile.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_tile.dart';
import '../player/AudioPage.dart';
import '../player/new_audio_player_page.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  static const _genres = genres;
  int index = 0;
  late double _widgetScalling;
  late double _textScale;
  late double _textFormScale;
  late Size _size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _widgetScalling = scaleSmallDevice(context);
    _textScale = textScaleRatio(context);
    _textFormScale = textFormTopRatio(context);
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 10, 19),
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBarWidget(
                    size: _size,
                    widgetScalling: _widgetScalling,
                    textScale: _textScale,
                    textFormScale: _textFormScale),
              ],
              body: SizedBox(
                height: _size.height,
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
                                      _size.width * 0.03 * _widgetScalling),
                              child: Text(
                                textParts[1],
                                // audio.genre!,
                                textScaleFactor: 2.0 * _textScale,
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
                                      _size.width * 0.03 * _widgetScalling),
                              child: SizedBox(
                                height: _size.height * 0.003 * _widgetScalling,
                                width: _size.width * 0.35 * _widgetScalling,
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
                                  top: _size.height * 0.02 * _widgetScalling),
                              child: SizedBox(
                                height: _size.height * 0.28 * _widgetScalling,
                                child: BlocProvider(
                                  create: (context) =>
                                      AudioBloc(getAudioUseCase: sl()),
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _genres.length,
                                    itemBuilder: (context, itemIndex) {
                                      return BlocProvider(
                                        create: (context) =>
                                            AudioBloc(getAudioUseCase: sl()),
                                        child: VinylPlayList(
                                            genreKey: _genres[itemIndex],
                                            index: itemIndex),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return BlocProvider(
                          create: (context) => AudioBloc(getAudioUseCase: sl()),
                          child: GenreList(
                            genreKey: _genres[index],
                            index: index,
                          ),
                        );
                      }
                    }),
              ),
            )
          ],
        ));
  }
}

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    required this.size,
    required this.widgetScalling,
    required this.textScale,
    required this.textFormScale,
  });

  final Size size;
  final double widgetScalling;
  final double textScale;
  final double textFormScale;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                      left: size.width * 0.1 * widgetScalling,
                      top: size.height * 0.01 * widgetScalling),
                  child: Image.asset('assets/images/logo_app.png',
                      fit: BoxFit.fill,
                      width: size.width * 0.2 * widgetScalling,
                      height: size.height * 0.1 * widgetScalling),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: size.width * 0.1 * widgetScalling),
                  child: Container(
                    height: size.height * 0.03 * widgetScalling,
                    width: size.width * 0.43 * widgetScalling,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 247, 255))),
                    child: MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: 1.0 * textScale),
                      child: TextFormField(
                        cursorWidth: 1.0,
                        cursorColor: const Color.fromARGB(255, 236, 39, 243),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 247, 255),
                            fontFamily: BitsFont.segoeItalicFont),
                        decoration: InputDecoration(
                          focusColor: Colors.transparent,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 247, 255),
                              fontFamily: BitsFont.spaceMono),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.height * 0.12 * textFormScale,
                              horizontal: size.width * 0.3 * textFormScale),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                AccountSettingsButtonWidget(
                    size: size, widgetScalling: widgetScalling)
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: size.height * 0.12 * widgetScalling),
              child: SizedBox(
                height: size.height * 0.05,
                width: size.width,
                child: ListView.builder(
                  shrinkWrap: true,
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
    );
  }
}

class AccountSettingsButtonWidget extends StatelessWidget {
  const AccountSettingsButtonWidget({
    super.key,
    required this.size,
    required this.widgetScalling,
  });

  final Size size;
  final double widgetScalling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.03 * widgetScalling),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/five');
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
    );
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
  late double _widgetScalling;
  late double _textScale;
  late Size _size;
  OverlayEntry? entry;
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
  void initState() {
    super.initState();
    BlocProvider.of<AudioBloc>(context)
        .add(FetchAudioEvent(genre: widget.genreKey));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _widgetScalling = scaleSmallDevice(context);
    _textScale = textScaleRatio(context);
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    _audioProvider = Provider.of<AudioProvider>(context).index;

    print("Hello - " + _audioProvider.toString());
    void showInSnackBar(String value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
            height: _size.height * 0.04,
            width: _size.width * 1.0,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                    color: Colors.black, fontFamily: BitsFont.segoeItalicFont),
              ),
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
      ));
    }

    return BlocBuilder<AudioBloc, AudioState>(
        // listenWhen: (previous, current) {
        //   return current is AudioInitial || current is AudioLoading;
        // },

        builder: (context, state) {
      if (state is AudioLoading) {
        const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AudioLoadedWithSuccess) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _size.width * 0.03 * _widgetScalling),
              child: Text(
                textParts[widget.index],
                // audio.genre!,
                textScaleFactor: 2.0 * _textScale,
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
                  horizontal: _size.width * 0.03 * _widgetScalling),
              child: SizedBox(
                height: _size.height * 0.003 * _widgetScalling,
                width: _size.width * 0.35 * _widgetScalling,
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
                        colors:
                            TextGradients.dividerGradientList[widget.index]),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: SizedBox(
                height: _size.height * 0.44 * _widgetScalling,
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 2.0,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                      state.trackList!.length < 5 ? state.trackList!.length : 4,
                      (index) {
                    return VinylAudioTileWidget(
                      vinylName: state.trackList![index].audioName,
                      onTap: () {
                        keyGlobal.currentState!.createOverlay(context, _size,
                            state.trackList, index, _widgetScalling);
                        // _insertOverlay(
                        //     context, _size, state.trackList, _audioProvider);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       // builder: (context) => const TestAnimationWidget()
                        //       builder: (context) => AudioPlayerPage(
                        //         index: index,
                        //         // index: index,
                        //         audioList: state.trackList,
                        //         // audioLink:
                        //         //     value.audioItem![
                        //         //             index][
                        //         //         'audioLink'],
                        //         // imageLink:
                        //         //     value.audioItem![
                        //         //             index][
                        //         //         'imageLink'],
                        //         // audioName:
                        //         //     value.audioItem![
                        //         //             index][
                        //         //         'audioName'],
                        //       ),
                        //       ),
                        // );
                      },
                      author: state.trackList![index].login,
                      mainImage: state.trackList![index].imageLink,
                      vinylImage: state.trackList![index].imageLink,
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      } else if (state is AudioLoadedWithError) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => showInSnackBar(state.message));
      }
      return const Center(child: CircularProgressIndicator());
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
  late double _widgetScalling;
  late Size _size;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AudioBloc>(context)
        .add(FetchAudioEvent(genre: widget.genreKey));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _widgetScalling = scaleSmallDevice(context);
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(builder: (context, state) {
      if (state is AudioLoading) {
        const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AudioLoadedWithSuccess) {
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
                  height: _size.height * 0.44 * _widgetScalling,
                  child: VinylPlaylistTile(
                    vinylName: state.trackList![0].audioName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AudioPlayerListPage(
                                  // index: index,
                                  audioList: state.trackList,
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
                    author: state.trackList![0].login,
                    mainImage: state.trackList![0].imageLink,
                    vinylImage: state.trackList![0].imageLink,
                  )),
            ),
          ],
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
