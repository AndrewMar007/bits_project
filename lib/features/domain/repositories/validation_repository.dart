import '../../data/models/validation_model.dart';

abstract class ValidationRepository {
  Future<ValidationModel> validateEmail(String? val);

  Future<ValidationModel> validatePassword(String? val);

  Future<ValidationModel> validateRequestResponse(int val);
}
