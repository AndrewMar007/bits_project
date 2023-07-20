import 'package:bits_project/features/data/models/validation_model.dart';

abstract class ValidationUsecase<Type> {
  ValidationModel? callValidation({required val});
}
