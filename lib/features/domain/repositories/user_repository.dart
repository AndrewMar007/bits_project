import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?>? getUser(String? email, String? password);
  Future<UserModel?>? sendUser(String? email, String? password, String? login);
}
