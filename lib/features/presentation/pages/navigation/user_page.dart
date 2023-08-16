import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/datasources/user_local_data_source.dart';
import '../../../domain/entities/user_entity.dart';
import '../../provider/user_provider.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/buttons/neumorph_icon_button.dart';
import '../../widgets/text_field_components/polymorphic_text_field.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final nameController = TextEditingController();
  final proffessionController = TextEditingController();
  final descriptionController = TextEditingController();

  void _removeUserCurrentSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(CACHED_USER);
  }

  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        color: const Color.fromARGB(255, 211, 214, 253),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.01 * widgetScalling,
            ),
            AppBar(
              automaticallyImplyLeading: false,
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: size.height * 0.025 * widgetScalling,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Account settings',
                    textScaleFactor: 12.0 * textFormScale,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: BitsFont.bitsFont),
                  ),
                  NeumorphIconButton(
                    30.0,
                    icon: Icons.more_horiz_outlined,
                    width: size.width * 0.1 * widgetScalling,
                    height: size.height * 0.05 * widgetScalling,
                    onTap: () {
                      _removeUserCurrentSession();
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/first');
                    },
                  ),
                ],
              ),
              toolbarHeight: size.height * 0.08 * widgetScalling,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: size.height * 0.05 * widgetScalling,
            ),
            Center(
              child: Container(
                height: size.height * 0.15 * widgetScalling,
                width: size.width * 0.4 * widgetScalling,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: -const Offset(4, 4),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      blurRadius: 10.0,
                    ),
                    const BoxShadow(
                      offset: Offset(4, 4),
                      color: Color.fromARGB(95, 0, 0, 0),
                      blurRadius: 10.0,
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 211, 214, 253),
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Center(
              child: Text(
                'Tap to choose image',
                textScaleFactor: 1.5 * textScale,
                style: const TextStyle(fontFamily: BitsFont.segoeItalicFont),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1 * widgetScalling,
                vertical: size.height * 0.015 * widgetScalling,
              ),
              child: Text(
                'Change your login',
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
                hintText: 'Your login now - ${user.login}',
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015 * widgetScalling,
                horizontal: size.width * 0.1 * widgetScalling,
              ),
              child: Text(
                'Change your email',
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
                hintText: 'Your email - ${user.email}',
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015 * widgetScalling,
                horizontal: size.width * 0.1 * widgetScalling,
              ),
              child: Text(
                'Enter your description',
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
                hintText: 'Write something about yourself',
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
              child: NeumorphButton(
                30.0,
                text: "Send information",
                fontFamily: BitsFont.segoeItalicFont,
                height: size.height * 0.05 * widgetScalling,
                width: size.width * 0.6 * widgetScalling,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
