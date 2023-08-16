import 'package:bits_project/core/usecases/usecase.dart';
import 'package:bits_project/features/data/models/user_model.dart';

import '../repositories/user_repository.dart';

class SendUser extends SignUpUseCase<UserModel> {
  final UserRepository repository;
  SendUser(this.repository);
  @override
  Future<UserModel?>? call(
      {required String email,
      required String password,
      required String login}) async {
    return repository.sendUser(email, password, login);
  }
}
