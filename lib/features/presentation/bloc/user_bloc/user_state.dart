import '../../../data/models/user_model.dart';

abstract class UserState {}

class UserInit extends UserState {}

class UserLoading extends UserState {}

class UserSignInSuccessState extends UserState {
  UserModel userModel;
  UserSignInSuccessState({required this.userModel});
}

class UserSignInErrorState extends UserState {
  String? message;
  UserSignInErrorState({this.message});
}

class UserSignUpSuccessState extends UserState {
  UserModel? userModel;
  UserSignUpSuccessState({this.userModel});
}

class UserSignUpErrorState extends UserState {
  String? message;
  UserSignUpErrorState({this.message});
}
