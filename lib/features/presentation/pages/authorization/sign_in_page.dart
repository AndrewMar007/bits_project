import 'package:bits_project/features/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:bits_project/features/presentation/bloc/user_bloc/user_event.dart';
import 'package:bits_project/features/presentation/bloc/user_bloc/user_state.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/valiadtion_bloc.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/validation_event.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/validation_state.dart';
import 'package:bits_project/features/presentation/pages/authorization/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/config.dart';
import '../../../../core/values/device_platform_scale.dart';
import '../../widgets/text_field_components/error_text.dart';
import '../../provider/user_provider.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/buttons/neumorph_button.dart';
import '../../widgets/text_field_components/polymorphic_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widgetScalling = scaleSmallDevice(context);
    double textScale = textScaleRatio(context);
    Size size = MediaQuery.of(context).size;
    double headerWidgetHeight = size.height * 0.45 * widgetScalling;

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
                height: headerWidgetHeight,
                child: HeaderWidget(headerWidgetHeight),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.07 * widgetScalling),
                    LogoImageWidget(size: size, widgetScalling: widgetScalling),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05 * widgetScalling,
                        bottom: size.height * 0.1 * widgetScalling,
                      ),
                      child: WelcomeTextWidget(textScale: textScale),
                    ),
                    const UserFormWidget(),
                    SizedBox(height: size.height * 0.01 * widgetScalling),
                    SizedBox(height: size.height * 0.04 * widgetScalling),
                    ForgotPassButtonWidget(textScale: textScale),
                    SizedBox(
                      height: size.height * 0.03 * widgetScalling,
                    ),
                    AppTextWidget(textScale: textScale),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({super.key});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validate = false;
  bool _emailState = false;
  bool _passwordState = false;
  String? _email, _password;
  String? _emailError, _passwordError;
  UserBloc? _userBloc;
  ValiadtionBloc? _validationBloc;
  UserProvider? _userProvider;
  late double widgetScalling;
  late double textScale;
  late double textFormScale;
  late Size size;
  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _validationBloc = BlocProvider.of<ValiadtionBloc>(context);
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  _callValidation(ValidationState state) {
    if (state is LoadingEmailValidation) {
      setState(() {
        _emailState = false;
      });
    }
    if (state is LoadingPasswordValidation) {
      setState(() {
        _passwordState = false;
      });
    }
    if (state is ShowErrorEmailValidation) {
      setState(() {
        _validate = true;
        _emailState = false;
      });
      _emailError = state.validationModel!.error;
    }
    if (state is ShowErrorPasswordValidation) {
      setState(() {
        _passwordState = false;
        _validate = true;
      });
      _passwordError = state.validationModel!.error!;
    }
    if (state is CompleteEmailValidation) {
      setState(() {
        _emailState = true;

        _emailError = '';
      });
    }
    if (state is CompletePasswordValidation) {
      setState(() {
        _passwordState = true;
        _passwordError = '';
      });
    }
    if (_emailState == true && _passwordState == true) {
      _userBloc!.add(SignInUserEvent(_email, _password));
    }
  }

  @override
  void didChangeDependencies() {
    widgetScalling = scaleSmallDevice(context);
    textScale = textScaleRatio(context);
    textFormScale = textFormTopRatio(context);
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
    if (kDebugMode) {
      print("Height of screen${size.height}");
      print("Width of the screen${size.width}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // ValidationRepositoryImpl validationRepo =
    //     Provider.of<ValidationRepositoryImpl>(context);

    // final validEmail = validationRepo.validateEmail(_emailController.text);
    // final validPassword =
    //     validationRepo.validatePassword(_passwordController.text);

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

    //double headerWidgetHeight = size.height * 0.45 * widgetScalling;

    return BlocListener<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UserSignInSuccessState) {
          _userProvider!.setUser(state.userModel);
          Navigator.pushNamedAndRemoveUntil(
              context, '/fourth', (Route<dynamic> route) => false);
        } else if (state is UserSignInErrorState) {
          showInSnackBar(state.message!);
        }
      },
      child: Column(
        children: [
          SizedBox(height: size.height * 0.01 * widgetScalling),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1 * widgetScalling),
            child: SizedBox(
              height: size.height * 0.2 * widgetScalling,
              child: BlocListener<ValiadtionBloc, ValidationState>(
                bloc: _validationBloc,
                listener: (context, state) {
                  _callValidation(state);
                },
                child: Form(
                    child: Column(
                  children: [
                    MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: 1.4 * textScale),
                      child: PolimorphicFormField(
                        contHeight: size.height * 0.18 * textFormScale,
                        contWidth: size.width * 0.06 * widgetScalling,
                        width: size.width * 2.2 * widgetScalling,
                        height: size.height * 0.06 * widgetScalling,
                        onTap: () {
                          setState(() {
                            _validate = false;
                          });
                        },
                        isPassword: false,
                        onChanged: (text) => {_email = text},
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005 * widgetScalling,
                    ),
                    ErrorText(
                      textScaleFactor: 1.0 * textScale,
                      milliseconds: 500,
                      visibility: _validate,
                      // text: '',
                      text: _emailError,
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      alignment: Alignment.centerLeft,
                      style: const TextStyle(
                        fontFamily: BitsFont.segoeItalicFont,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005 * widgetScalling,
                    ),
                    MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: 1.4 * textScale),
                      child: PolimorphicFormField(
                        contHeight: size.height * 0.18 * textFormScale,
                        contWidth: size.width * 0.06 * widgetScalling,
                        width: size.width * 2.2 * widgetScalling,
                        height: size.height * 0.06 * widgetScalling,
                        onTap: () {
                          setState(() {
                            _validate = false;
                          });
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
                      text: _passwordError,
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      alignment: Alignment.centerLeft,
                      style:
                          const TextStyle(fontFamily: BitsFont.segoeItalicFont),
                    ),
                  ],
                )),
              ),
            ),
          ),
          NeumorphButton(
            15.0,
            textScaleFactor: 2.0 * textScale,
            fontFamily: BitsFont.segoeItalicFont,
            height: size.height * 0.07 * widgetScalling,
            width: size.width * 0.3 * widgetScalling,
            text: "Sign-In",
            onTap: () {
              _validationBloc!.add(EmailValidation(_emailController.text));
              _validationBloc!
                  .add(PasswordValidation(_passwordController.text));
            },
          ),
          SizedBox(
            height: size.height * 0.06 * widgetScalling,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
                    _validate = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    required this.textScale,
  });

  final double? textScale;

  @override
  Widget build(BuildContext context) {
    return Text(
      textScaleFactor: 1.1 * textScale!,
      "BitsWave LTD. 2023",
      style: const TextStyle(
          fontFamily: BitsFont.segoeItalicFont,
          color: Color.fromARGB(255, 41, 41, 41)),
    );
  }
}

class ForgotPassButtonWidget extends StatelessWidget {
  const ForgotPassButtonWidget({
    super.key,
    required this.textScale,
  });

  final double? textScale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   showDialog(
      //       useSafeArea: false,
      //       barrierColor: Colors.transparent,
      //       context: context,
      //       builder: (BuildContext context) =>
      //           const PopUpForgotMenu());
      // },
      child: Text(
        textScaleFactor: 1.5 * textScale!,
        'Forgotten password?',
        style: const TextStyle(
          color: Color.fromARGB(255, 39, 39, 39),
          fontFamily: BitsFont.segoeItalicFont,
        ),
      ),
    );
  }
}

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
    required this.textScale,
  });

  final double? textScale;

  @override
  Widget build(BuildContext context) {
    return Text('Welcome',
        textScaleFactor: 5.0 * textScale!,
        style: const TextStyle(shadows: [
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 30.0,
            color: Color(0xFF09FDF4),
          )
        ], fontFamily: BitsFont.bitsFont, color: Color(0xFF09FDF4)));
  }
}

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({
    super.key,
    required this.size,
    required this.widgetScalling,
  });

  final Size size;
  final double? widgetScalling;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.4 * widgetScalling!,
      height: size.height * 0.18 * widgetScalling!,
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
        image: BitsImage.imageLogo,
      )),
    );
  }
}
