import 'package:bits_project/core/usecases/validation_usecase.dart';
import 'package:bits_project/features/domain/repositories/validation_repository.dart';

import '../../data/models/validation_model.dart';

class ValidateEmail implements ValidationUsecase {
  final ValidationRepository repository;

  ValidateEmail({required this.repository});

  @override
  Future<ValidationModel> callValidation({required val}) async {
    return repository.validateEmail(val);
  }
}
