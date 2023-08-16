import 'package:bits_project/features/presentation/pages/authorization/sign_in_page.dart';
import 'package:bits_project/features/presentation/pages/authorization/sign_up_page.dart';
import 'package:bits_project/features/presentation/pages/navigation/cupertino_bottom_bar.dart';
import 'package:bits_project/features/presentation/pages/navigation/playlist_view.dart';
import 'package:bits_project/features/presentation/pages/navigation/upload_audio_page.dart';
import 'package:bits_project/features/presentation/pages/navigation/user_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/first':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/second':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/third':
        return MaterialPageRoute(builder: (_) => const PlaylistView());
      // if (args is OverlayEntry) {
      //   return MaterialPageRoute(
      //       builder: (_) => PlaylistView(
      //             entry: args,
      //           ));
      // }
      // return _errorRoute();
      case '/fourth':
        return MaterialPageRoute(builder: (_) => const CupertinoBottomBar());
      case '/five':
        return MaterialPageRoute(builder: (_) => const UserPage());
      case '/six':
        return MaterialPageRoute(builder: (_) => const UploadAudioPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(body: Center(child: Text("Error")));
    });
  }
}
