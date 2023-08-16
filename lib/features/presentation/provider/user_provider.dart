import 'package:bits_project/features/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
