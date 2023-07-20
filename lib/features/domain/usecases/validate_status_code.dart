import '../../../core/usecases/validation_usecase.dart';
import '../repositories/validation_repository.dart';

class ValidateStatusCode implements ValidationUsecase {
  final ValidationRepository repository;

  ValidateStatusCode({required this.repository});
  @override
  callValidation({required val}) {
    return repository.validateRequestResponse(val)!;
  }
}
