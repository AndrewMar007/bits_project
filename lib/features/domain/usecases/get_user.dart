import 'package:bits_project/core/usecases/usecase.dart';
import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/domain/repositories/user_repository.dart';

import '../entities/user_entity.dart';

class GetUser implements UseCase<User> {
  final UserRepository repository;

  GetUser(this.repository);
  @override
  Future<UserModel?>? call(
      {required String email, required String password}) async {
    return await repository.getUser(email, password);
  }
}
