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
import 'features/data/repositories/audio_repository_impl.dart';
import 'features/presentation/bloc/user_bloc/user_bloc.dart';
import 'features/presentation/injection_container.dart' as di;
import 'features/presentation/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
