import 'package:bits_project/features/data/datasources/user_local_data_source.dart';
import 'package:bits_project/features/data/repositories/validation_repository_impl.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/valiadtion_bloc.dart';
import 'package:bits_project/features/presentation/pages/authorization/sign_in_page.dart';
import 'package:bits_project/features/presentation/pages/navigation/bottom_navigation_bar_pages.dart';
import 'package:bits_project/features/presentation/pages/navigation/cupertino_bottom_bar.dart';
import 'package:bits_project/features/presentation/provider/audio_provider.dart';
import 'package:bits_project/features/presentation/provider/user_provider.dart';
import 'package:bits_project/features/presentation/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/values/page_manager.dart';
import 'features/data/repositories/audio_repository_impl.dart';
import 'features/presentation/bloc/user_bloc/user_bloc.dart';
import 'features/presentation/injection_container.dart' as di;
import 'features/presentation/injection_container.dart';

void main() async {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(const MyApp());
  //FlutterNativeSplash.remove();
  //await Future.delayed(const Duration(seconds: 3));
}
//Remove current instance of user

// void deleteUserFromShared() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove(CACHED_USER);
// }
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          // ChangeNotifierProvider<UserRepositoryImpl>(
          //   create: (context) => UserRepositoryImpl(
          //       networkInfo: sl(),
          //       userLocalDataSource: sl(),
          //       userRemoteDataSource: sl()),
          // ),
          ChangeNotifierProvider(create: (context) => AudioProvider()),

          BlocProvider<ValiadtionBloc>(
            create: (context) => ValiadtionBloc(
                validationEmailUseCase: sl(), validationPasswordUseCase: sl()),
          ),
          BlocProvider<UserBloc>(
              create: (context) =>
                  UserBloc(fetchUserUseCase: sl(), sendUserUseCase: sl())),
          ChangeNotifierProvider<ValidationRepositoryImpl>(
              create: (context) => ValidationRepositoryImpl()),
          ListenableProvider<AudioRepositoryImpl>(
              create: (context) => AudioRepositoryImpl(
                  remoteDataSource: sl(), networkInfo: sl()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          home: FutureBuilder(
            future: di.sl<UserLocalDataSource>().savedUserSession(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.data == null) {
                return const LoginPage();
              } else {
                //deleteUserFromShared();
                // UserModel user = UserModel(
                //     email: snapshot.data!.email,
                //     id: snapshot.data!.id,
                //     login: snapshot.data!.login);
                Provider.of<UserProvider>(context, listen: false)
                    .setUser(snapshot.data!);
                return CupertinoBottomBar(
                  key: keyGlobal,
                );
              }
            },
          ),
          // initialRoute: '/first',
          onGenerateRoute: RouteGenerator.generateRoute,

          //home: DashBoard(),
          //home: MainPage(),
          // home: SplashScreen(
          //   route: FutureBuilder(
          //     future: getUserData(),
          //     builder: (context, snapshot) {
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.none:
          //         case ConnectionState.waiting:
          //           return const CircularProgressIndicator();
          //         default:
          //           // if (snapshot.hasError) {
          //           //   return Text('Error: ${snapshot.hasError}');
          //           // }
          //           if (snapshot.data!.email == null &&
          //               snapshot.data!.id == null &&
          //               snapshot.data!.authorName == null) {
          //             return const LoginPage();
          //           } else {
          //             User user = User(
          //                 email: snapshot.data!.email,
          //                 authorName: snapshot.data!.authorName,
          //                 id: snapshot.data!.id);
          //             Provider.of<UserProvider>(context, listen: false)
          //                 .setUser(user);
          //             return PlaylistView();
          //           }

          //         //return WelcomePage(user: snapshot.data);
          //       }
          //     },
          //   ),
          // ),

          // routes: {
          //   '/uploadPage': (context) => UploadAudioPage(),
          //   '/login': (context) => const LoginPage(),
          //   '/register': (context) => const SignUpPage(),
          //   '/user': (context) => const UserPage(),
          // },
        ));
  }
}

// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:flutter/material.dart';
// import 'core/values/page_manager.dart';
// import 'features/presentation/injection_container.dart' as di;
// import 'features/presentation/provider/notifiers/play_button_notifier.dart';
// import 'features/presentation/provider/notifiers/progress_notifier.dart';
// import 'features/presentation/provider/notifiers/repeat_button_notifier.dart';

// void main() async {
//   await di.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     di.sl<PageManager>().init();
//   }

//   @override
//   void dispose() {
//     di.sl<PageManager>().dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: const [
//               CurrentSongTitle(),
//               Playlist(),
//               AddRemoveSongButtons(),
//               AudioProgressBar(),
//               AudioControlButtons(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CurrentSongTitle extends StatelessWidget {
//   const CurrentSongTitle({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<String>(
//       valueListenable: pageManager.currentSongTitleNotifier,
//       builder: (_, title, __) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: Text(title, style: const TextStyle(fontSize: 40)),
//         );
//       },
//     );
//   }
// }

// class Playlist extends StatelessWidget {
//   const Playlist({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return Expanded(
//       child: ValueListenableBuilder<List<String>>(
//         valueListenable: pageManager.playlistNotifier,
//         builder: (context, playlistTitles, _) {
//           return ListView.builder(
//             itemCount: playlistTitles.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(playlistTitles[index]),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class AddRemoveSongButtons extends StatelessWidget {
//   const AddRemoveSongButtons({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           // FloatingActionButton(
//           //   onPressed: pageManager.add,
//           //   child: const Icon(Icons.add),
//           // ),
//           // FloatingActionButton(
//           //   onPressed: pageManager.remove,
//           //   child: const Icon(Icons.remove),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class AudioProgressBar extends StatelessWidget {
//   const AudioProgressBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<ProgressBarState>(
//       valueListenable: pageManager.progressNotifier,
//       builder: (_, value, __) {
//         return ProgressBar(
//           progress: value.current,
//           buffered: value.buffered,
//           total: value.total,
//           onSeek: pageManager.seek,
//         );
//       },
//     );
//   }
// }

// class AudioControlButtons extends StatelessWidget {
//   const AudioControlButtons({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: const [
//           RepeatButton(),
//           PreviousSongButton(),
//           PlayButton(),
//           NextSongButton(),
//           ShuffleButton(),
//         ],
//       ),
//     );
//   }
// }

// class RepeatButton extends StatelessWidget {
//   const RepeatButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<RepeatState>(
//       valueListenable: pageManager.repeatButtonNotifier,
//       builder: (context, value, child) {
//         Icon icon;
//         switch (value) {
//           case RepeatState.off:
//             icon = const Icon(Icons.repeat, color: Colors.grey);
//             break;
//           case RepeatState.repeatSong:
//             icon = const Icon(Icons.repeat_one);
//             break;
//           case RepeatState.repeatPlaylist:
//             icon = const Icon(Icons.repeat);
//             break;
//         }
//         return IconButton(
//           icon: icon,
//           onPressed: pageManager.repeat,
//         );
//       },
//     );
//   }
// }

// class PreviousSongButton extends StatelessWidget {
//   const PreviousSongButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isFirstSongNotifier,
//       builder: (_, isFirst, __) {
//         return IconButton(
//           icon: const Icon(Icons.skip_previous),
//           onPressed: (isFirst) ? null : pageManager.previous,
//         );
//       },
//     );
//   }
// }

// class PlayButton extends StatelessWidget {
//   const PlayButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<ButtonState>(
//       valueListenable: pageManager.playButtonNotifier,
//       builder: (_, value, __) {
//         switch (value) {
//           case ButtonState.loading:
//             return Container(
//               margin: const EdgeInsets.all(8.0),
//               width: 32.0,
//               height: 32.0,
//               child: const CircularProgressIndicator(),
//             );
//           case ButtonState.paused:
//             return IconButton(
//               icon: const Icon(Icons.play_arrow),
//               iconSize: 32.0,
//               onPressed: pageManager.play,
//             );
//           case ButtonState.playing:
//             return IconButton(
//               icon: const Icon(Icons.pause),
//               iconSize: 32.0,
//               onPressed: pageManager.pause,
//             );
//         }
//       },
//     );
//   }
// }

// class NextSongButton extends StatelessWidget {
//   const NextSongButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isLastSongNotifier,
//       builder: (_, isLast, __) {
//         return IconButton(
//           icon: const Icon(Icons.skip_next),
//           onPressed: (isLast) ? null : pageManager.next,
//         );
//       },
//     );
//   }
// }

// class ShuffleButton extends StatelessWidget {
//   const ShuffleButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final pageManager = di.sl<PageManager>();
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isShuffleModeEnabledNotifier,
//       builder: (context, isEnabled, child) {
//         return IconButton(
//           icon: (isEnabled)
//               ? const Icon(Icons.shuffle)
//               : const Icon(Icons.shuffle, color: Colors.grey),
//           onPressed: pageManager.shuffle,
//         );
//       },
//     );
//   }
// }
