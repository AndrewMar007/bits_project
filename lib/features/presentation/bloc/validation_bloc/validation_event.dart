abstract class ValidationEvent {}

class EmailValidation<T> extends ValidationEvent {
  T value;
  EmailValidation(this.value);
}

class PasswordValidation<T> extends ValidationEvent {
  T value;
  PasswordValidation(this.value);
}
