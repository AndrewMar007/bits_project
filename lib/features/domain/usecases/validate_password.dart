import 'package:bits_project/core/usecases/validation_usecase.dart';
import 'package:bits_project/features/domain/repositories/validation_repository.dart';

import '../../data/models/validation_model.dart';

class ValidatePassword implements ValidationUsecase {
  final ValidationRepository repository;

  ValidatePassword({required this.repository});

  @override
  Future<ValidationModel> callValidation({required val}) async {
    return repository.validatePassword(val);
  }
}
