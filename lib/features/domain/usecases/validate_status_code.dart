import '../../../core/usecases/validation_usecase.dart';
import '../../data/models/validation_model.dart';
import '../repositories/validation_repository.dart';

class ValidateStatusCode implements ValidationUsecase {
  final ValidationRepository repository;

  ValidateStatusCode({required this.repository});
  @override
  Future<ValidationModel?> callValidation({required val}) async {
    return repository.validateRequestResponse(val);
  }
}
