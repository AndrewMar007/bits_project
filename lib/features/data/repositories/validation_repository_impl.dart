import 'package:bits_project/core/values/regex_extension.dart';
import 'package:bits_project/features/data/models/validation_model.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/validation_repository.dart';

class ValidationRepositoryImpl
    with ChangeNotifier
    implements ValidationRepository {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);

  ValidationModel get email => _email;
  ValidationModel get password => _password;

  @override
  Future<ValidationModel> validateEmail(String? val) async {
    if (val != null && val.isValidEmail) {
      _email = ValidationModel(val, null);
      return _email;
    } else if (val!.isEmpty == true) {
      _email = ValidationModel(null, 'Field is empty');
      return _email;
    } else {
      _email = ValidationModel(null, 'Please enter a Valid Email');
      return _email;
    }
  }

  @override
  Future<ValidationModel> validatePassword(String? val) async {
    if (val != null && val.isValidPassword) {
      _password = ValidationModel(val, null);
      return _password;
    } else if (val!.isEmpty == true) {
      _password = ValidationModel(null, 'Field is empty');
      return _password;
    } else {
      _password = ValidationModel(null,
          'Password must contain an uppercase, lowercase, numeric digit and special character');
      return _password;
    }
  }

  @override
  Future<ValidationModel> validateRequestResponse(int val) async {
    if (val == 400) {
      _email == ValidationModel(null, 'Bad request');
      return _email;
    } else if (val == 401) {
      _email == ValidationModel(null, 'Unauthorized exception');
      return _email;
    } else if (val == 403) {
      _email = ValidationModel(null, 'Email exist');
      return _email;
    } else if (val == 404) {
      _email = ValidationModel(null, 'Resource not found');
      return _email;
    } else if (val == 500) {
      _email = ValidationModel(null, 'Internal server error');
      return _email;
    } else {
      _email = ValidationModel(null, 'Unhandled Server Failre');
      return _email;
    }
  }
}
