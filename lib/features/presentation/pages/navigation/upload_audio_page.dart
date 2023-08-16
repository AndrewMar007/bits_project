import 'dart:convert';
import 'dart:io';

import 'package:bits_project/features/data/repositories/audio_repository_impl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/models/audio_model.dart';
import '../../../data/models/user_model.dart';
import '../../provider/user_provider.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/dropdown_menu.dart';
import '../../widgets/overlay_player.dart';
import '../../widgets/text_field_components/polymorphic_text_field.dart';
import '../../widgets/vinyl_widgets/vinyl_widget.dart';
import '../../widgets/vinyl_widgets/vinyl_widget_image.dart';
import 'cupertino_bottom_bar.dart';

class UploadAudioPage extends StatefulWidget {
  const UploadAudioPage({super.key});

  @override
  State<UploadAudioPage> createState() => _UploadAudioPageState();
}

class _UploadAudioPageState extends State<UploadAudioPage> {
  late AudioRepositoryImpl _audioProv;
  FilePickerResult? result;
  File? fileToDisplay;
  PlatformFile? pickedFile;
  File? fileToDisplayVinyl;
  PlatformFile? pickedFileVinyl;
  bool isLoading = false;
  final nameController = TextEditingController();
  final genreController = TextEditingController();
  String? genreValue;
  String defaultValue = 'Pop';

  @override
  void initState() {
    _audioProv = Provider.of<AudioRepositoryImpl>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OverlayScreen.of(context);
    double? widgetScalling = scaleSmallDevice(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context).user;
    AudioModel audio;

    mainImage() async {
      setState(() {
        isLoading = true;
      });
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result != null) {
        pickedFile = result.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        // imageProv.upload(file.name, base64Encode(file.bytes!),
        //     user.id); //base64Encode used to convert bytes in base64URL
        // print(pickedFile!.name);
        // print(base64Encode(pickedFile!.bytes!));
        // print(pickedFile!.size);
        // print(pickedFile!.extension);
        // print(pickedFile!.path);
        // print(result);
        // print(fileToDisplay);
      } else {
        // User canceled the picker
      }
      setState(() {
        isLoading = false;
      });
    }

    uploadAudio() async {
      setState(() {
        isLoading = true;
      });

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result != null) {
        pickedFileVinyl = result.files.first;
        fileToDisplayVinyl = File(pickedFileVinyl!.path.toString());
        // imageProv.upload(file.name, base64Encode(file.bytes!),
        //     user.id); //base64Encode used to convert bytes in base64URL

        // print('Original path: ${fileToDisplayVinyl!.path}');
        // String dir = p.dirname(fileToDisplayVinyl!.path);
        // String newPath = p.join(dir, 'Vitamin D');
        // print('New Path: ${newPath}');
        // fileToDisplayVinyl!.rename(newPath);
        if (kDebugMode) {
          print("Audio path - ${fileToDisplayVinyl!.path}");
        }
        //print("Encode Base64 - " + base64Encode(pickedFileVinyl!.bytes!));
        //String base = base64Encode(pickedFileVinyl!.bytes!);
        // print("Decode Base64 - " +
        //     base64Decode(
        //             "data:audio/wav;base64,${base64Encode(pickedFileVinyl!.bytes!)}")
        //         .toString());
        if (kDebugMode) {
          print(pickedFileVinyl!.name);
        }
        // print(base64Encode(pickedFile!.bytes!));
        // print(pickedFileVinyl!.size);
        // print(pickedFileVinyl!.extension);
        // print(pickedFileVinyl!.path);
        // print(result);
        // print(fileToDisplayVinyl);
        // print("Bytes - " + pickedFileVinyl!.bytes!.toString());
        // print("Base 64 - " + base64Encode(pickedFileVinyl!.bytes!));
        // print("Decode Base 64 - " +
        //     base64Decode(base64Encode(pickedFileVinyl!.bytes!)).toString());
      } else {
        // User canceled the picker
      }
      setState(() {
        isLoading = false;
      });
    }

    if (kDebugMode) {
      print("Check user - ${user.id}${user.email}${user.password}");
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 211, 214, 253),
            //     gradient: LinearGradient(colors: [
            //   const Color.fromARGB(255, 255, 44, 192).withOpacity(0.4),
            //   const Color.fromARGB(255, 15, 247, 255).withOpacity(0.4)
            // ])),
          ),
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                // leading: GestureDetector(
                //   child: Icon(
                //     Icons.arrow_back_ios_new,
                //     color: Colors.black,
                //     size: size.height * 0.025 * widgetScalling!,
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                centerTitle: true,
                title: Text(
                  'Upload music',
                  textScaleFactor: 12.0 * textFormScale,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: BitsFont.bitsFont),
                ),
                toolbarHeight: size.height * 0.08 * widgetScalling,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              // SizedBox(
              //   height: size.height * 0.05 * widgetScalling,
              // ),
              if (pickedFile == null)
                const Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 30.0, top: 10.0),
                  child: VinylWidgetImage(
                      vinylDuration: Duration(),
                      mainImage: 'assets/images/LogoBit.png',
                      vinylImage: 'assets/images/LogoBit.png'),
                ),
              if (pickedFile != null)
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : VinylWidget(
                          vinylDuration: const Duration(),
                          mainImage: fileToDisplay!,
                          vinylImage: fileToDisplay!,
                        ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01 * widgetScalling,
                ),
                child: Text(
                  'Choose from gallery image and audio',
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontFamily: BitsFont.segoeItalicFont),
                  textScaleFactor: 8.0 * textFormScale,
                ),
              ),
              SizedBox(
                height: size.height * 0.02 * widgetScalling,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphButton(30.0,
                      text: "Choose image",
                      fontFamily: BitsFont.segoeItalicFont,
                      height: size.height * 0.05 * widgetScalling,
                      width: size.width * 0.3 * widgetScalling, onTap: () {
                    mainImage();
                  }),
                  SizedBox(width: size.width * 0.1 * widgetScalling),
                  NeumorphButton(
                    30.0,
                    text: "Choose audio",
                    fontFamily: BitsFont.segoeItalicFont,
                    height: size.height * 0.05 * widgetScalling,
                    width: size.width * 0.3 * widgetScalling,
                    onTap: () {
                      // uploadAudio();
                    },
                  ),
                ],
              ),
              // if (pickedFileVinyl != null)
              //   Padding(
              //       padding: const EdgeInsets.all(30.0),
              //       child: isLoading
              //           ? const CircularProgressIndicator()
              //           : Text(pickedFileVinyl!.name)),
              SizedBox(
                height: size.height * 0.02 * widgetScalling,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.015 * widgetScalling,
                ),
                child: Text(
                  'Audio name',
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontFamily: BitsFont.segoeItalicFont),
                  textScaleFactor: 8.0 * textFormScale,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05 * widgetScalling),
                child: PolimorphicFormField(
                  contHeight: size.height * 0.18 * textFormScale,
                  contWidth: size.width * 0.06 * widgetScalling,
                  width: size.width * 2.2 * widgetScalling,
                  height: size.height * 0.06 * widgetScalling,
                  onTap: () => {
                    setState(() {
                      //   _validate = false;
                    })
                  },
                  controller: nameController,
                  isPassword: false,
                  //onChanged: (text) => {_email = text},
                  //controller: _emailController,
                  hintText: 'Enter song name',
                ),
              ),
              SizedBox(
                height: size.height * 0.01 * widgetScalling,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.015 * widgetScalling,
                ),
                child: Text(
                  'Choose genre for your audio',
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontFamily: BitsFont.segoeItalicFont),
                  textScaleFactor: 8.0 * textFormScale,
                ),
              ),
              Center(
                child: DropDownMenu(
                  height: size.height * 0.06 * widgetScalling,
                  width: size.width * 0.4 * widgetScalling,
                  value: defaultValue,
                  items: dropdownItems,
                  onChanged: (String? newValue) {
                    setState(() {
                      defaultValue = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(
                height: size.height * 0.05 * widgetScalling,
              ),
              NeumorphButton(
                30.0,
                text: "Send audio",
                fontFamily: BitsFont.segoeItalicFont,
                height: size.height * 0.05 * widgetScalling,
                width: size.width * 0.6 * widgetScalling,
                onTap: () {
                  if (kDebugMode) {
                    print(defaultValue);
                    print(user.id);
                    print(user.login);
                  }

                  // "data:audio/mp3;base64,${base64.encode(pickedFileVinyl!.bytes!)}",
                  audio = AudioModel(
                      audioName: nameController.text,
                      imageLink: base64Encode(pickedFile!.bytes!),
                      audioLink: base64Encode(pickedFileVinyl!.bytes!),
                      genre: defaultValue,
                      userId: user.id,
                      login: user.login);
                  _audioProv.sendAudio(audio);
                  // audioProv.sendAudio(
                  //     nameController.text,
                  //     base64Encode(pickedFileVinyl!.bytes!),
                  //     base64Encode(pickedFile!.bytes!),
                  //     defaultValue,
                  //     user.id,
                  //     user.authorName);
                },
              ),
              // SizedBox(
              //   height: size.height * 0.05 * widgetScalling,
              // ),
              // if (_image != null)
              //   Image.file(
              //     height: 400,
              //     width: 200,
              //     _image!,
              //     fit: BoxFit.cover,
              //   ),
              // Center(
              //     child: isLoading
              //         ? CircularProgressIndicator()
              //         : TextButton(
              //             child: Text('Choose image'),
              //             onPressed: () {
              //               file();
              //             },
              //           )),
              // if (pickedFile != null)
              //   SizedBox(
              //       height: 300, width: 400, child: Image.file(fileToDisplay!)),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: VinylWidget(
              //     vinylDuration: Duration(),
              //     mainImage: fileToDisplay!,
              //     vinylImage: 'lib/images/vitamin.png',
              //   ),
              // ),

              //  Center(child: Text(user.email!)),

              // SizedBox(height: 100),
              // OutlineGradientButton(
              //     onTap: () {},
              //     corners: Corners(
              //         topRight: Radius.elliptical(50, 36),
              //         bottomLeft: Radius.circular(36.0)),
              //     strokeWidth: 1.0,
              //     gradient: LinearGradient(colors: [
              //       Color.fromARGB(255, 229, 35, 210),
              //       Color.fromARGB(255, 35, 255, 255),
              //     ]),
              //     child: Text('Logout',
              //         style: TextStyle(
              //             shadows: [
              //               Shadow(
              //                 offset: Offset(0.0, 0.0),
              //                 blurRadius: 30.0,
              //                 color: Color(0xFF09FDF4),
              //               )
              //             ],
              //             fontSize: 16,
              //             fontFamily: "Edo",
              //             color: Color(0xFF09FDF4)))),
            ],
          ),
        ),
      ),
    );
  }
}
