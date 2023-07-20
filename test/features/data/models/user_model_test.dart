import 'dart:convert';

import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final userModel = UserModel(
      id: '6478a647a487bbf4b9080134',
      email: "avicii@gmail.com",
      login: 'Avicii');
  test('should be a subclass of User entity', () async {
    expect(userModel, isA<User>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when we got the JSON ',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('mock_user.json'));

        final result = UserModel.fromJson(jsonMap);
        // expect(result, isA<UserModel>());
        // expect(userModel, isA<UserModel>());
        expect(result, isInstanceOf<UserModel>());
      },
    );
  });

  group('toJson', () {
    test('should return JSON map containing the proper data', () async {
      final result = userModel.toJson();
      final expectedMap = {
        "_id": "6478a647a487bbf4b9080134",
        "email": "avicii@gmail.com",
        "nickName": "Avicii"
      };
      expect(result, expectedMap);
    });
  });
}
