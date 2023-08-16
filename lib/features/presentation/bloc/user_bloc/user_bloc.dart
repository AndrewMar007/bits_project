import 'package:bits_project/features/presentation/bloc/user_bloc/user_event.dart';
import 'package:bits_project/features/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_user.dart';
import '../../../domain/usecases/send_user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUser? fetchUserUseCase;
  final SendUser? sendUserUseCase;
  UserBloc({this.fetchUserUseCase, this.sendUserUseCase}) : super(UserInit()) {
    on<SignInUserEvent>(_fetchUser);
    on<SignUpUserEvent>(_sendUser);
  }

  _fetchUser(SignInUserEvent event, Emitter<UserState> emitter) async {
    emitter(UserLoading());
    try {
      final result = await fetchUserUseCase!
          .call(email: event.email!, password: event.password!);
      emitter(UserSignInSuccessState(userModel: result!));
    } catch (e) {
      emitter(UserSignInErrorState(message: e.toString()));
    }
  }

  _sendUser(SignUpUserEvent event, Emitter<UserState> emitter) async {
    emitter(UserLoading());
    // try {
    //   final result = await sendUserUseCase!.call(
    //       email: event.email!, password: event.password!, login: event.login!);
    //   emitter(UserSignUpSuccessState(userModel: result));
    // } catch (e) {
    //   emitter(UserSignUpErrorState());
    // }
  }
}
