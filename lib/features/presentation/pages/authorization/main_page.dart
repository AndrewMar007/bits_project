import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/presentation/pages/navigation/playlist_view.dart';
import 'package:bits_project/features/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Text(user.id!),
            Text(user.email!),
            Text(user.login!),
            TextButton(
                onPressed: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return const PlaylistView();
                  // }));
                },
                child: const Text('OpenListView'))
          ],
        ),
      ),
    );
  }
}
