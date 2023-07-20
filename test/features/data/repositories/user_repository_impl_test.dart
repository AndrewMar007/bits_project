import 'package:bits_project/core/network/network_info.dart';
import 'package:bits_project/features/data/datasources/user_local_data_source.dart';
import 'package:bits_project/features/data/datasources/user_remote_data_source.dart';
import 'package:bits_project/features/data/models/user_model.dart';
import 'package:bits_project/features/data/repositories/user_repository_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
        userRemoteDataSource: mockRemoteDataSource,
        userLocalDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getUser', () {
    const email = 'andy';
    const password = '123';

    final userModel = UserModel(
        id: 'id', email: 'email', password: 'password', login: 'login');

    final UserModel user = userModel;

    test('should check if the device online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
        return Future<bool>.value(true);
      });
      await repository.getUser(email, password);
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async {
          return Future<bool>.value(true);
        });
      });
      test(
          'should return remote data when the call to remote data source is success',
          () async {
        when(() => mockRemoteDataSource.getUser(any(), any())).thenAnswer((_) {
          return Future<UserModel>.value(userModel);
        });

        final result = await repository.getUser(email, password);

        verify(() => mockRemoteDataSource.getUser(email, password));

        expect(result, equals(user));
      });

      test(
          'should cache user data locally when the call to remote data source is success',
          () async {
        when(() => mockRemoteDataSource.getUser(any(), any())).thenAnswer((_) {
          return Future<UserModel>.value(userModel);
        });

        await repository.getUser(email, password);

        verify(() => mockRemoteDataSource.getUser(email, password));
        verify(() => mockLocalDataSource.cacheUserData(userModel));
      });

      // test(
      //     'should return server failure when te call to remote data source is successfull',
      //     () async {
      //   when(() => mockRemoteDataSource.getUser(any(), any()))
      //       .thenAnswer((_) => Future.error(Exception()));
      //   User? result;
      //   Exception? error;
      //   try {
      //     result = await repository.getUser(email, password);
      //   } on Exception {
      //     error = Exception();
      //   }

      //   verify(() => mockRemoteDataSource.getUser(email, password));
      //   verifyZeroInteractions(mockLocalDataSource);
      //   expect(error, Exception());
      // });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
          return Future<bool>.value(false);
        });
      });
      test(
          'should return last user cached entry when the cached user is present',
          () async {
        when(() => mockLocalDataSource.savedUserSession())
            .thenAnswer((_) async {
          return await Future<UserModel>.value(userModel);
        });
        final result = await repository.getUser(email, password);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.savedUserSession());
        expect(result, equals(user));
      });

      // test('should return CacheFailure when there is no cached data present',
      //     () async {
      //   when(() => mockLocalDataSource.savedUserSession())
      //       .thenThrow(ServerException());

      //   final result = await repository.getUser(email, password);

      //   verifyZeroInteractions(mockRemoteDataSource);
      //   verify(() => mockLocalDataSource.savedUserSession());
      //   expect(result, isInstanceOf<ServerException>());
      // });
    });
  });

  group('sendUser', () {
    const email = 'andy';
    const password = '123';
    const authorName = 'Avicii';

    final userModel = UserModel(
        id: 'id', email: 'email', password: 'password', login: 'login');

    final UserModel user = userModel;

    test('should check if the device online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
        return Future<bool>.value(true);
      });
      repository.sendUser(email, password, authorName);
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async {
          return Future<bool>.value(true);
        });
      });
      test(
          'should send data to remote when the call to remote data source is success',
          () async {
        when(() => mockRemoteDataSource.sendUser(any(), any(), any()))
            .thenAnswer((_) {
          return Future<UserModel>.value(userModel);
        });

        final result = await repository.sendUser(email, password, authorName);

        verify(
            () => mockRemoteDataSource.sendUser(email, password, authorName));

        expect(result, equals(user));
      });

      test(
          'should cache user data locally when the call to remote data source is success',
          () async {
        when(() => mockRemoteDataSource.sendUser(any(), any(), any()))
            .thenAnswer((_) {
          return Future<UserModel>.value(userModel);
        });

        await repository.sendUser(email, password, authorName);

        verify(
            () => mockRemoteDataSource.sendUser(email, password, authorName));
        verify(() => mockLocalDataSource.cacheUserData(userModel));
      });

      // test(
      //     'should reutrn server failure when te call to remote data source is successfull',
      //     () async {
      //   when(() => mockRemoteDataSource.sendUser(any(), any(), any()))
      //       .thenThrow(ServerException());
      //   final result = await repository.sendUser(email, password, authorName);

      //   verify(
      //       () => mockRemoteDataSource.sendUser(email, password, authorName));
      //   verifyZeroInteractions(mockLocalDataSource);
      //   expect(result, isInstanceOf<Left>());
      // });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
          return Future<bool>.value(false);
        });
      });
      test(
          'should return last user cached entry when the cached user is present',
          () async {
        when(() => mockLocalDataSource.savedUserSession())
            .thenAnswer((_) async {
          return await Future<UserModel>.value(userModel);
        });
        final result = await repository.sendUser(email, password, authorName);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.savedUserSession());
        expect(result, equals(user));
      });

      // test('should return CacheFailure when there is no cached data present',
      //     () async {
      //   when(() => mockLocalDataSource.savedUserSession())
      //       .thenThrow(CacheException());

      //   final result = await repository.sendUser(email, password, authorName);

      //   verifyZeroInteractions(mockRemoteDataSource);
      //   verify(() => mockLocalDataSource.savedUserSession());
      //   expect(result, isInstanceOf<Left>());
      // });
    });
  });
}
