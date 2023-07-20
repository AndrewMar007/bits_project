import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/presentation/pages/authorization/main_page.dart';
import 'package:bits_project/features/presentation/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../data/repositories/validation_repository_impl.dart';
import '../../widgets/text_field_components/error_text.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/text_field_components/polymorphic_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = TextEditingController();
  bool _validate = false;

  String? _email, _password, _login;
  @override
  Widget build(BuildContext context) {
    double? widgetScalling = scaleSmallDevice(context);
    double? textScale = textScaleRatio(context);
    double? textFormScale = textFormTopRatio(context);
    UserRepositoryImpl auth = Provider.of<UserRepositoryImpl>(context);
    UserModel? user = Provider.of<UserProvider>(context).user;
    ValidationRepositoryImpl validationRepo =
        Provider.of<ValidationRepositoryImpl>(context);

    // final validEmail = validationRepo.validateEmail(_emailController.text);
    // final validPassword =
    //     validationRepo.validatePassword(_passwordController.text);

    void doRegister() {
      final getUserData = auth.sendUser(
        _email!,
        _password!,
        _login!,
      );
      getUserData.then((response) {
        final userData = response;
        Provider.of<UserProvider>(context, listen: false).setUser(userData!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          ),
        );
        //  else {
        //   setState(() {
        //     auth.validateRequestResponse;
        //     _validate = true;
        //   });
        // }
      }).catchError((err) {
        if (kDebugMode) {
          print(err);
        }
        setState(() {
          _validate = true;
          validationRepo.validateRequestResponse(err);
        });
      });
    }

    Size size = MediaQuery.of(context).size;
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
          child: Stack(
            children: [
              SizedBox(
                height: height,
                child: HeaderWidget(height),
              ),
              Center(
                child: Column(children: [
                  Stack(
                    children: [
                      AppBar(
                        leading: GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: size.height * 0.03 * widgetScalling,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        toolbarHeight: size.height * 0.08 * widgetScalling,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.05 * widgetScalling,
                              bottom: size.height * 0.1 * widgetScalling,
                            ),
                            child: Text('Registration',
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
                              height: size.height * 0.24 * widgetScalling,
                              child: Column(
                                children: [
                                  MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: 1.4 * textScale),
                                    child: PolimorphicFormField(
                                      contHeight:
                                          size.height * 0.16 * textFormScale!,
                                      contWidth:
                                          size.width * 0.06 * widgetScalling,
                                      width: size.width * 2.2 * widgetScalling,
                                      height:
                                          size.height * 0.05 * widgetScalling,
                                      onTap: () => {
                                        setState(() {
                                          _validate = false;
                                        })
                                      },
                                      isPassword: false,
                                      onChanged: (text) => {_login = text},
                                      controller: _loginController,
                                      hintText: 'Nickname',
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        size.height * 0.005 * widgetScalling,
                                  ),
                                  ErrorText(
                                    textScaleFactor: 1.0 * textScale,
                                    milliseconds: 500,
                                    visibility: _validate,
                                    text: '',
                                    //text: auth..error.toString(),
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    alignment: Alignment.centerLeft,
                                    style: const TextStyle(
                                        fontFamily: BitsFont.segoeItalicFont),
                                  ),
                                  SizedBox(
                                    height:
                                        size.height * 0.005 * widgetScalling,
                                  ),
                                  MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: 1.4 * textScale),
                                    child: PolimorphicFormField(
                                      contHeight:
                                          size.height * 0.16 * textFormScale,
                                      contWidth:
                                          size.width * 0.06 * widgetScalling,
                                      width: size.width * 2.2 * widgetScalling,
                                      height:
                                          size.height * 0.05 * widgetScalling,
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
                                    height:
                                        size.height * 0.005 * widgetScalling,
                                  ),
                                  ErrorText(
                                    textScaleFactor: 1.0 * textScale,
                                    milliseconds: 500,
                                    visibility: _validate,
                                    text: validationRepo.email.error.toString(),
                                    // text: auth.email.error.toString(),
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    alignment: Alignment.centerLeft,
                                    style: const TextStyle(
                                        fontFamily: BitsFont.segoeItalicFont),
                                  ),
                                  SizedBox(
                                    height:
                                        size.height * 0.005 * widgetScalling,
                                  ),
                                  MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: 1.4 * textScale),
                                    child: PolimorphicFormField(
                                      contHeight:
                                          size.height * 0.16 * textFormScale,
                                      contWidth:
                                          size.width * 0.06 * widgetScalling,
                                      width: size.width * 2.2 * widgetScalling,
                                      height:
                                          size.height * 0.05 * widgetScalling,
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
                                    height: size.height * 0.01 * widgetScalling,
                                  ),
                                  ErrorText(
                                    textScaleFactor: 1.0 * textScale,
                                    milliseconds: 500,
                                    visibility: _validate,
                                    text: validationRepo.password.error
                                        .toString(),
                                    // text: auth.password.error.toString(),
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    alignment: Alignment.centerLeft,
                                    style: const TextStyle(
                                        fontFamily: BitsFont.segoeItalicFont),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05 * widgetScalling,
                          ),
                          Consumer<UserRepositoryImpl>(
                              builder: (context, model, child) {
                            return NeumorphButton(
                              15.0,
                              textScaleFactor: 2.0 * textScale,
                              fontFamily: BitsFont.segoeItalicFont,
                              height: size.height * 0.07 * widgetScalling,
                              width: size.width * 0.3 * widgetScalling,
                              text: "Sign-Up",
                              onTap: () {
                                final validEmail = validationRepo
                                    .validateEmail(_emailController.text);
                                final validPassword = validationRepo
                                    .validatePassword(_passwordController.text);
                                // if (auth.validateEmail(
                                //             _emailController.text) ==
                                //         null &&
                                //     auth.validatePassword(
                                //             _passwordController.text) ==
                                //         null) {
                                //   _validate = true;
                                // }
                                // if (auth.email.error == null &&
                                //     auth.password.error == null) {
                                //   _validate = false;
                                //   auth.loggedInStatus ==
                                //           Status.Authenticating
                                //       ? print('loading...')
                                //       : doRegister();
                                // }
                                if (validEmail!.value == null &&
                                    validPassword!.value == null) {
                                  setState(() {
                                    _validate = true;
                                  });
                                }
                                if (validationRepo.email.value != null &&
                                    validationRepo.password.value != null) {
                                  setState(() {
                                    _validate = false;
                                  });

                                  // auth.loggedInStatus == Status.Authenticating
                                  //     ? print('loading...')
                                  doRegister();
                                }
                              },
                            );
                          }),
                          SizedBox(
                            height: size.height * 0.02 * widgetScalling,
                          ),
                          Text(
                            textScaleFactor: 1.1 * textScale,
                            "By using our app you are agreeing to our Privacy Policy",
                            style: const TextStyle(
                                fontFamily: BitsFont.segoeItalicFont,
                                color: Color.fromARGB(255, 48, 48, 48)),
                          ),
                          SizedBox(
                            height: size.height * 0.02 * widgetScalling,
                          ),
                          NeumorphButton(
                            15.0,
                            textScaleFactor: 1.0 * textScale,
                            text: 'Privacy Policy',
                            height: size.height * 0.04 * widgetScalling,
                            width: size.width * 0.25 * widgetScalling,
                            fontFamily: BitsFont.segoeItalicFont,
                            onTap: () {
                              setState(() {
                                _validate = false;
                              });
                              // showDialog(
                              //     useSafeArea: false,
                              //     barrierColor: Colors.transparent,
                              //     context: context,
                              //     barrierDismissible: true,
                              //     builder: (BuildContext context) =>
                              //         const PopUpPrivacyMenu());
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.04 * widgetScalling,
                          ),
                          Text(
                            textScaleFactor: 1.0 * textScale,
                            "BitsWave LTD. 2022",
                            style: const TextStyle(
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
