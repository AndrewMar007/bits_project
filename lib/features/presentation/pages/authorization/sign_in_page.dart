import 'package:bits_project/features/data/repositories/user_repository_impl.dart';

import 'package:bits_project/features/presentation/pages/authorization/main_page.dart';
import 'package:bits_project/features/presentation/pages/authorization/sign_up_page.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/validation_repository_impl.dart';
import '../../widgets/text_field_components/error_text.dart';
import '../../provider/user_provider.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/text_field_components/polymorphic_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validate = false;

  String? _email, _password;
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    Size size = MediaQuery.of(context).size;

    ValidationRepositoryImpl validationRepo =
        Provider.of<ValidationRepositoryImpl>(context);
    UserRepositoryImpl auth = Provider.of<UserRepositoryImpl>(context);

    void showInSnackBar(String value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
            height: size.height * 0.04,
            width: size.width * 1.0,
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

    final validEmail = validationRepo.validateEmail(_emailController.text);
    final validPassword =
        validationRepo.validatePassword(_passwordController.text);

    void loginFunc() {
      final successfulMessage = auth.getUser(_email!, _password!);
      successfulMessage!.then((response) {
        UserModel? userData = response;
        Provider.of<UserProvider>(context, listen: false).setUser(userData!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          ),
        );
      }).catchError((err) {
        if (kDebugMode) {
          print(err);
        }
        showInSnackBar(
            'No Internet connection turn on Wi-Fi or mobile internet');
      });
    }

    double height = size.height * 0.45 * widgetScalling!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 255, 44, 192).withOpacity(0.4),
            const Color.fromARGB(255, 15, 247, 255).withOpacity(0.15)
          ])),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SizedBox(
                height: height,
                child: HeaderWidget(height),
              ),
              // VideoPlayer(_videoController!),
              // Container(color: Colors.white),
              Center(
                child: Column(children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: size.height * 0.07 * widgetScalling),
                          Container(
                            width: size.width * 0.4 * widgetScalling,
                            height: size.height * 0.18 * widgetScalling,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                              image: BitsImage.imageLogo,
                            )),
                          ),
                          //SizedBox(height: size.height * .0),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.05 * widgetScalling,
                              bottom: size.height * 0.1 * widgetScalling,
                            ),
                            child: Text('Welcome',
                                textScaleFactor: 5.0 * textScale!,
                                style: const TextStyle(
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 30.0,
                                        color: Color(0xFF09FDF4),
                                      )
                                    ],
                                    fontFamily: BitsFont.bitsFont,
                                    color: Color(0xFF09FDF4))),
                          ),
                          SizedBox(height: size.height * 0.01 * widgetScalling),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1 * widgetScalling),
                            child: SizedBox(
                              height: size.height * 0.21 * widgetScalling,
                              child: Form(
                                  key: formGlobalKey,
                                  child: Column(
                                    children: [
                                      MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            textScaleFactor: 1.4 * textScale),
                                        child: PolimorphicFormField(
                                          contHeight: size.height *
                                              0.18 *
                                              textFormScale!,
                                          contWidth: size.width *
                                              0.06 *
                                              widgetScalling,
                                          width:
                                              size.width * 2.2 * widgetScalling,
                                          height: size.height *
                                              0.06 *
                                              widgetScalling,
                                          onTap: () => {
                                            setState(() {
                                              _validate = false;
                                            })
                                          },
                                          isPassword: false,
                                          onChanged: (text) => {_email = text},
                                          controller: _emailController,
                                          hintText: 'Email',
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height *
                                            0.005 *
                                            widgetScalling,
                                      ),
                                      ErrorText(
                                        textScaleFactor: 1.0 * textScale,
                                        milliseconds: 500,
                                        visibility: _validate,
                                        // text: '',
                                        text: validationRepo.email.error
                                            .toString(),
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        alignment: Alignment.centerLeft,
                                        style: const TextStyle(
                                          fontFamily: BitsFont.segoeItalicFont,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height *
                                            0.005 *
                                            widgetScalling,
                                      ),
                                      MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            textScaleFactor: 1.4 * textScale),
                                        child: PolimorphicFormField(
                                          contHeight: size.height *
                                              0.18 *
                                              textFormScale,
                                          contWidth: size.width *
                                              0.06 *
                                              widgetScalling,
                                          width:
                                              size.width * 2.2 * widgetScalling,
                                          height: size.height *
                                              0.06 *
                                              widgetScalling,
                                          onTap: () => {
                                            setState(() {
                                              _validate = false;
                                            })
                                          },
                                          isPassword: true,
                                          controller: _passwordController,
                                          onChanged: (String? value) {
                                            _password = value;
                                          },
                                          hintText: 'Password',
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            size.height * 0.01 * widgetScalling,
                                      ),
                                      ErrorText(
                                        textScaleFactor: 1.0 * textScale,
                                        milliseconds: 500,
                                        visibility: _validate,
                                        text: validationRepo.password.error
                                            .toString(),
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        alignment: Alignment.centerLeft,
                                        style: const TextStyle(
                                            fontFamily:
                                                BitsFont.segoeItalicFont),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Consumer<UserRepositoryImpl>(
                              builder: (context, model, child) {
                            return NeumorphButton(
                              15.0,
                              textScaleFactor: 2.0 * textScale,
                              fontFamily: BitsFont.segoeItalicFont,
                              height: size.height * 0.07 * widgetScalling,
                              width: size.width * 0.3 * widgetScalling,
                              text: "Sign-In",
                              onTap: () {
                                if (validEmail!.value == null &&
                                    validPassword!.value == null) {
                                  setState(() {
                                    _validate = true;
                                  });
                                }
                                if (validationRepo.email.value != null &&
                                    validationRepo.password.value != null) {
                                  _validate = false;
                                  // auth.loggedInStatus == Status.Authenticating
                                  //     ? print('loading...')
                                  loginFunc();
                                }
                              },
                            );
                          }),
                          SizedBox(
                            height: size.height * 0.06 * widgetScalling,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  textScaleFactor: 1.3 * textScale,
                                  "Do not have an account yet? Tap ",
                                  style: const TextStyle(
                                      fontFamily: BitsFont.segoeItalicFont,
                                      color: Color.fromARGB(255, 37, 37, 37)),
                                ),
                                NeumorphButton(
                                  15.0,
                                  textScaleFactor: 1.2 * textScale,
                                  fontFamily: BitsFont.segoeItalicFont,
                                  text: 'Sign-Up',
                                  height: size.height * 0.05 * widgetScalling,
                                  width: size.width * 0.2 * widgetScalling,
                                  onTap: () {
                                    setState(() {
                                      _validate = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.04 * widgetScalling),
                          GestureDetector(
                            // onTap: () {
                            //   showDialog(
                            //       useSafeArea: false,
                            //       barrierColor: Colors.transparent,
                            //       context: context,
                            //       builder: (BuildContext context) =>
                            //           const PopUpForgotMenu());
                            // },
                            child: Text(
                              textScaleFactor: 1.5 * textScale,
                              'Forgotten password?',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 39, 39, 39),
                                fontFamily: BitsFont.segoeItalicFont,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03 * widgetScalling,
                          ),
                          Text(
                            textScaleFactor: 1.1 * textScale,
                            "BitsWave LTD. 2023",
                            style: const TextStyle(

                                // shadows: [
                                //   Shadow(
                                //     offset: Offset(0.0, 0.0),
                                //     blurRadius: 30.0,
                                //     color: Color(0xFF09FDF4),
                                //   )
                                // ],
                                fontFamily: BitsFont.segoeItalicFont,
                                color: Color.fromARGB(255, 41, 41, 41)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
