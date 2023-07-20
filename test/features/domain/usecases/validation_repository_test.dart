import 'package:bits_project/features/data/models/validation_model.dart';
import 'package:bits_project/features/domain/repositories/validation_repository.dart';
import 'package:bits_project/features/domain/usecases/validate_email.dart';
import 'package:bits_project/features/domain/usecases/validate_password.dart';
import 'package:bits_project/features/domain/usecases/validate_status_code.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockValidationRepository extends Mock implements ValidationRepository {}

void main() {
  late ValidateStatusCode valResReqUseCase;
  late ValidateEmail emailUseCase;
  late ValidatePassword passwordUseCase;
  late MockValidationRepository mockValidationRepository;

  setUp(() {
    mockValidationRepository = MockValidationRepository();
    emailUseCase = ValidateEmail(repository: mockValidationRepository);
    passwordUseCase = ValidatePassword(repository: mockValidationRepository);
    valResReqUseCase = ValidateStatusCode(repository: mockValidationRepository);
  });
  const val = 'text';
  const error = 'Email exist';
  final valModel = ValidationModel('text', null);
  final valModelError = ValidationModel(null, error);

  group('check call Validation', () {
    test('should get valid password value for Validation data from Repository',
        () {
      when(() => mockValidationRepository.validatePassword(any()))
          .thenAnswer((_) {
        return ValidationModel(val, null);
      });

      final result = passwordUseCase.callValidation(val: val);
      expect(result, valModel);
      verify(() => mockValidationRepository.validatePassword(val));
      verifyNoMoreInteractions(mockValidationRepository);
    });
    test('should get valid email value for Validation data from Repository',
        () {
      when(() => mockValidationRepository.validateEmail(any())).thenAnswer((_) {
        return ValidationModel(val, null);
      });

      final result = emailUseCase.callValidation(val: val);
      expect(result, valModel);
      verify(() => mockValidationRepository.validateEmail(val));
      verifyNoMoreInteractions(mockValidationRepository);
    });
  });

  test('should get valid error for Validation data from Response', () {
    when(() => mockValidationRepository.validateRequestResponse(any()))
        .thenAnswer((_) {
      return ValidationModel(null, 'Email exist');
    });
    final result = valResReqUseCase.callValidation(val: 403);
    expect(result, valModelError);
    verify(() => mockValidationRepository.validateRequestResponse(403));
    verifyNoMoreInteractions(mockValidationRepository);
  });

  test('should return null value if validation email data is empty', () {
    when(() => mockValidationRepository.validateEmail(any())).thenAnswer((_) {
      return valModelError;
    });

    final result = mockValidationRepository.validateEmail(val)!.error;
    expect(result, valModelError.error);
    verify(() => mockValidationRepository.validateEmail(val));
    verifyNoMoreInteractions(mockValidationRepository);
  });

  test(
      'should return error of password value for Validation data from Repository',
      () {
    when(() => mockValidationRepository.validatePassword(any()))
        .thenAnswer((_) {
      return valModelError;
    });

    final result = mockValidationRepository.validatePassword(null)!.error;
    expect(result, valModelError.error);
    verify(() => mockValidationRepository.validatePassword(null));
    verifyNoMoreInteractions(mockValidationRepository);
  });
  test('should return a StatusCode exception when response wil be wrong', () {
    when(() => mockValidationRepository.validateRequestResponse(any()))
        .thenAnswer((_) {
      return valModelError;
    });
    final result = mockValidationRepository.validateRequestResponse(403)!.error;
    expect(result, valModelError.error);
  });
}
