import 'package:bits_project/features/domain/usecases/validate_email.dart';
import 'package:bits_project/features/domain/usecases/validate_password.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/validation_event.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValiadtionBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidateEmail validationEmailUseCase;
  ValidatePassword validationPasswordUseCase;
  ValiadtionBloc(
      {required this.validationEmailUseCase,
      required this.validationPasswordUseCase})
      : super(InitValidation()) {
    on<EmailValidation>(_emailValidation);
    on<PasswordValidation>(_passwordValidation);
  }
  _emailValidation(
      EmailValidation event, Emitter<ValidationState> emitter) async {
    emitter(LoadingEmailValidation());

    // if (emitter is LoadingEmailValidation) {}
    final result =
        await validationEmailUseCase.callValidation(val: event.value);

    if (result.value == null || result.value!.isEmpty == true) {
      emitter(ShowErrorEmailValidation(validationModel: result));
    } else {
      emitter(CompleteEmailValidation(validationModel: result));
    }
  }

  _passwordValidation(
      PasswordValidation event, Emitter<ValidationState> emitter) async {
    emitter(LoadingPasswordValidation());
    final result =
        await validationPasswordUseCase.callValidation(val: event.value);
    if (result.value == null || result.value!.isEmpty == true) {
      emitter(ShowErrorPasswordValidation(validationModel: result));
    } else {
      emitter(CompletePasswordValidation(validationModel: result));
    }
  }
}
