// ignore_for_file: overridden_fields

import 'package:bits_project/features/domain/entities/validation_entity.dart';

class ValidationModel implements ValidationEntity {
  @override
  String? value;
  @override
  String? error;
  ValidationModel(this.value, this.error);

  @override
  bool operator ==(Object other) {
    return other is ValidationModel &&
        other.value == value &&
        other.error == error;
  }

  @override
  int get hashCode => value.hashCode;
}
