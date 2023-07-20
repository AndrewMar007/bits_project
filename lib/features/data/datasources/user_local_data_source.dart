import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel>? savedUserSession();
  Future<void>? cacheUserData(UserModel? userToCache);
}

// ignore: constant_identifier_names
const CACHED_USER = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel>? savedUserSession() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      return null;
    }
  }

  @override
  Future<void>? cacheUserData(UserModel? userToCache) {
    return sharedPreferences.setString(
        CACHED_USER, json.encode(userToCache!.toJson()));
  }
}
