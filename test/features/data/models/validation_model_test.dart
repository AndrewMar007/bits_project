import 'package:bits_project/features/data/models/validation_model.dart';
import 'package:bits_project/features/domain/entities/validation_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be a subclass of ValidationEntity', () {
    final testValidation = ValidationModel('true', 'All good');
    expect(testValidation, isA<ValidationEntity>());
  });
}
