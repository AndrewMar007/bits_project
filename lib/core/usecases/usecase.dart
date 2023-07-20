abstract class UseCase<Type> {
  Future<Type?>? call({required String email, required String password});
}
