import '../../data/models/validation_model.dart';

abstract class ValidationRepository {
  ValidationModel? validateEmail(String? val);

  ValidationModel? validatePassword(String? val);

  ValidationModel? validateRequestResponse(int val);
}
