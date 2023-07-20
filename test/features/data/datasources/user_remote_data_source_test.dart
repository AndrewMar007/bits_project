import 'dart:convert';
import 'package:bits_project/features/data/datasources/user_remote_data_source.dart';
import 'package:bits_project/features/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../../fixtures/fixture_reader.dart';

class MockUserHttpClient extends Mock implements http.Client {}

void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockUserHttpClient mockUserHttpClient;

  setUp(() {
    mockUserHttpClient = MockUserHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockUserHttpClient);
    registerFallbackValue(Uri.parse('http://192.168.137.1:3000/user'));
    registerFallbackValue(Uri.parse('http://192.168.137.1:3000/users'));
  });

  void setUpMockHttpClientSuccess200() {
    when(() => mockUserHttpClient.post(any(),
            body: json.encode({'email': 'andy@gmail.com', 'password': '123'}),
            headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response(fixture('mock_user.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockUserHttpClient.post(any(),
            body: json.encode({'email': 'andy@gmail.com', 'password': '123'}),
            headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientSuccess200ForSignIn() {
    when(() => mockUserHttpClient.post(
              any(),
              body: json.encode({
                'email': 'andy@gmail.com',
                'password': '123',
                'nickName': 'Avicii'
              }),
              headers: {'Content-Type': 'application/json'},
            ))
        .thenAnswer((_) async => http.Response(fixture('mock_user.json'), 200));
  }

  void setUpMockHttpClientFailure404ForSignIn() {
    when(() => mockUserHttpClient.post(any(),
            body: json.encode({
              'email': 'andy@gmail.com',
              'password': '123',
              'nickName': 'Avicii'
            }),
            headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getUser', () {
    const email = 'andy@gmail.com';
    const password = '123';
    Map<String, dynamic> loginData = {'email': email, 'password': password};
    UserModel? userModel =
        UserModel.fromJson(json.decode(fixture('user.json')));

    test(
        'should perform a POST request on a URL with email and password for login',
        () async {
      setUpMockHttpClientSuccess200();
      dataSource.getUser(email, password);

      verify(() => mockUserHttpClient.post(
          Uri.parse('http://192.168.137.1:3000/user'),
          body: json.encode(loginData),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return User when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getUser(email, password);

      expect(result, equals(userModel));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getUser;
      expect(() => call(email, password), throwsA(const TypeMatcher<int>()));
    });
  });

  group('sendUser', () {
    const email = 'andy@gmail.com';
    const password = '123';
    const login = 'Avicii';
    final userModel = UserModel.fromJson(json.decode(fixture('user.json')));
    Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
      'nickName': login,
    };

    test(
        'should perform a POST request on a URL with email and password for login',
        () async {
      setUpMockHttpClientSuccess200ForSignIn();
      dataSource.sendUser(email, password, login);

      verify(() => mockUserHttpClient.post(
          Uri.parse('http://192.168.137.1:3000/users'),
          body: json.encode(loginData),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return User when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200ForSignIn();

      final result = await dataSource.sendUser(email, password, login);

      expect(result, equals(userModel));
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404ForSignIn();

      final call = dataSource.sendUser;
      expect(() => call(email, password, login),
          throwsA(const TypeMatcher<int>()));
    });
  });
}
