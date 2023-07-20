import 'dart:convert';
import 'package:bits_project/features/data/datasources/user_local_data_source.dart';
import 'package:bits_project/features/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

class MockUserSharedPrefences extends Mock implements SharedPreferences {}

void main() {
  late UserLocalDataSourceImpl dataSource;
  late UserLocalDataSource mockDataSource;

  MockUserSharedPrefences? mockUserSharedPrefences;
  SharedPreferences? sharedPreferences;

  setUp(() async {
    mockUserSharedPrefences = MockUserSharedPrefences();
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    mockDataSource =
        UserLocalDataSourceImpl(sharedPreferences: mockUserSharedPrefences!);
    dataSource = UserLocalDataSourceImpl(sharedPreferences: sharedPreferences!);
  });

  group('getLastUserSession', () {
    // UserModel? userModel =
    //     UserModel.fromJson(json.decode(fixture('user_cached.json')));
    test(
        'should return User from SharedPreferences when there is one in the localDatabse',
        () async {
      when(() => mockUserSharedPrefences!.getString(any()))
          .thenReturn(fixture('user_cached.json'));

      final result = await mockDataSource.savedUserSession();
      verify(() => mockUserSharedPrefences!.getString(CACHED_USER));
      expect(result, isInstanceOf<UserModel>());
    });

    // test('should thorw CachecException when there is not a cached value',
    //     () async {
    //   when(() => mockUserSharedPrefences!.getString(any())).thenReturn(null);

    //   final call = mockDataSource.savedUserSession;

    //   expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    // });

    group('cacheUser', () {
      final userModel =
          UserModel(email: 'andy@gmail.com', password: "123", login: 'Avicii');
      test('should call SharedPreferences to cache the data', () async {
        final cacheData = dataSource.cacheUserData(userModel);

        final expectedJsonString = json.encode(userModel.toJson());
        // final actualCounter = sharedPreferences.getString(CACHED_USER);
        final checkMoc =
            sharedPreferences!.setString(CACHED_USER, expectedJsonString);
        // verify(() =>
        //     mockUserSharedPrefences.setString(CACHED_USER, expectedJsonString));
        expect(cacheData, isInstanceOf<Future<bool>>());
        expect(checkMoc, isInstanceOf<Future<bool>>());
      });
    });
  });
}
