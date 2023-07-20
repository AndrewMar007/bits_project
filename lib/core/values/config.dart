import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

//Add genres
const genres = ['Pop', 'getEDM', 'getHip'];

class BitsImage {
  static const AssetImage imageBG =
      AssetImage("assets/images/bitBackGround.png");
  static const AssetImage imageBGB = AssetImage("assets/images/bitBorders.png");
  static const AssetImage imageLogo = AssetImage("assets/images/bitLogo.png");
}

const AudioContext audioContext = AudioContext(
  iOS: AudioContextIOS(
      category: AVAudioSessionCategory.ambient,
      options: [AVAudioSessionOptions.defaultToSpeaker]),
);

String getApiURl() {
  if (Platform.isAndroid) {
    return 'http://192.168.137.1:3000';
  }
  if (Platform.isIOS) {
    return 'http://192.168.1.105:3000';
  }
  return 'http://192.168.1.105:3000';
}

class BitsFont {
  static const String bitsFont = "Bits";
  static const String segoeFont = "Segoe";
  static const String segoeItalicFont = "SegoeItalic";
  static const String spaceMono = 'Space';
}

class RiveAsset {
  String? nav;
  bool? input;
  Icon icon;
  //late SMIBool? input;
  final String? title;
  // RiveAsset(this.src,
  //     {required this.stateMachineName,
  //     required this.title,
  //     this.nav,
  //     required this.artboard,
  //     this.input});
  // set setInput(SMIBool? status) {
  //   input = status;
  // }
  RiveAsset({required this.icon, this.title, this.nav, this.input});
  set setInput(bool? status) {
    input = status;
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(
      value: 'Pop',
      child: Text('Pop'),
    ),
    DropdownMenuItem(
      value: 'EDM',
      child: Text('EDM'),
    ),
    DropdownMenuItem(
      value: 'Hip Hop',
      child: Text('Hip Hop'),
    ),
    DropdownMenuItem(
      value: 'Rap',
      child: Text('Rap'),
    ),
    DropdownMenuItem(
      value: 'Instrumental',
      child: Text('Instrumental'),
    ),
    DropdownMenuItem(
      value: 'Folk',
      child: Text('Folk'),
    ),
  ];
  return menuItems;
}

List<RiveAsset> sideNavs = [
  RiveAsset(
      title: 'Upload music',
      nav: '/dashboard',
      icon: const Icon(
        Icons.upload_file_sharp,
        color: Colors.white,
      )),
  RiveAsset(
      title: 'Account',
      nav: '/user',
      icon: const Icon(
        Icons.person,
        color: Colors.white,
      )),
  RiveAsset(
      title: 'Settings',
      nav: '/login',
      icon: const Icon(
        Icons.settings,
        color: Colors.white,
      )),
  RiveAsset(
      title: 'Library',
      nav: '/register',
      icon: const Icon(
        Icons.library_books,
        color: Colors.white,
      ))
  // RiveAsset("lib/images/icons.riv",
  //     title: "Home",
  //     stateMachineName: "HOME_interactivity",
  //     artboard: "HOME",
  //     nav: '/dashboard'),
  // RiveAsset("lib/images/icons.riv",
  //     title: "Search",
  //     stateMachineName: "SEARCH_Interactivity",
  //     artboard: "SEARCH",
  //     nav: '/login'),
  // RiveAsset("lib/images/icons.riv",
  //     title: "User",
  //     stateMachineName: "STAR_Interactivity",
  //     artboard: "LIKE/STAR"),
  // RiveAsset("lib/images/icons.riv",
  //     title: "Help", stateMachineName: "CHAT_Interactivity", artboard: "CHAT"),
];

List textParts = [
  'LISTEN AGAIN',
  'MIXES OF YOUR MUSIC',
  'Hip-Hop music',
  'Rap music',
  'Instrumental music',
  'Folk music'
];
List textButtons = ['ENERGY', 'VACATION', 'TRAINING', 'TRAVEL'];
