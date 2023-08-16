import 'package:bits_project/features/data/models/validation_model.dart';

abstract class ValidationState {}

class InitValidation extends ValidationState {}

class LoadingEmailValidation extends ValidationState {}

class LoadingPasswordValidation extends ValidationState {}

class ShowErrorEmailValidation extends ValidationState {
  ValidationModel? validationModel;
  ShowErrorEmailValidation({this.validationModel});
}

class CompleteEmailValidation extends ValidationState {
  ValidationModel? validationModel;
  CompleteEmailValidation({this.validationModel});
}

class ShowErrorPasswordValidation extends ValidationState {
  ValidationModel? validationModel;
  ShowErrorPasswordValidation({this.validationModel});
}

class CompletePasswordValidation extends ValidationState {
  ValidationModel? validationModel;
  CompletePasswordValidation({this.validationModel});
}
