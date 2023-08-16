import 'package:bits_project/core/usecases/usecase.dart';
import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/domain/repositories/user_repository.dart';

class FetchUser implements SignInUseCase<UserModel> {
  final UserRepository repository;

  FetchUser(this.repository);
  @override
  Future<UserModel?>? call(
      {required String email, required String password}) async {
    return await repository.getUser(email, password);
  }
}
