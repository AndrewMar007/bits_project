abstract class SignInUseCase<Type> {
  Future<Type?>? call({required String email, required String password});
}

abstract class SignUpUseCase<Type> {
  Future<Type?>? call(
      {required String email, required String password, required String login});
}
