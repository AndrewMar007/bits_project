import 'dart:convert';

import '../../../core/values/config.dart';
import '../models/user_model.dart';
import '../repositories/validation_repository_impl.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel>? getUser(String? email, String? password);
  Future<UserModel>? sendUser(String? email, String? password, String? login);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  late ValidationRepositoryImpl validationRepository;

  @override
  Future<UserModel>? getUser(String? email, String? password) {
    Map<String, dynamic> userData = {'email': email, 'password': password};
    return _getOrSendUser('${getApiURl()}/user', userData);
  }

  @override
  Future<UserModel>? sendUser(String? email, String? password, String? login) {
    Map<String, dynamic> userData = {
      'email': email,
      'password': password,
      'nickName': login,
    };

    return _getOrSendUser('${getApiURl()}/users', userData);
  }

  Future<UserModel>? _getOrSendUser(
      String url, Map<String, dynamic> userData) async {
    final response = await client.post(
      Uri.parse(url),
      body: json.encode(userData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseDecoded = json.decode(response.body);

      return UserModel.fromJson(responseDecoded['user']!);
    } else {
      throw response.statusCode;
    }
  }
}
