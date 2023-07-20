import 'dart:async';
import 'package:bits_project/core/error/exceptions.dart';
import 'package:bits_project/core/error/failures.dart';
import 'package:bits_project/features/data/datasources/user_local_data_source.dart';
import 'package:bits_project/features/data/datasources/user_remote_data_source.dart';
import 'package:bits_project/features/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/network_info.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl with ChangeNotifier implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.userRemoteDataSource,
      required this.userLocalDataSource,
      required this.networkInfo});

  @override
  Future<UserModel?>? getUser(String? email, String? password) async {
    if (await networkInfo.isConnected) {
      UserModel? remoteUser =
          await userRemoteDataSource.getUser(email, password);
      userLocalDataSource.cacheUserData(remoteUser);
      notifyListeners();
      return remoteUser;
    } else {
      try {
        final localUser = await userLocalDataSource.savedUserSession();
        notifyListeners();
        return localUser;
      } on CacheException {
        return Future.error(CacheFailure);
      }
    }
    // return await userRemoteDataSource.getUser(email, password);
  }

  @override
  Future<UserModel?> sendUser(
      String? email, String? password, String? login) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await userRemoteDataSource.sendUser(email, password, login);
        userLocalDataSource.cacheUserData(remoteUser);
        notifyListeners();
        return remoteUser;
      } on ServerException {
        return Future.error(ServerFailure);
      }
    } else {
      try {
        final localUser = await userLocalDataSource.savedUserSession();
        notifyListeners();
        return localUser;
      } on CacheException {
        return Future.error(CacheFailure);
      }
    }
  }

  // Future<Either<Failure, User>> _getUser() async {
  //    if (await networkInfo.isConnected) {
  //     try {
  //       final remoteUser = await userRemoteDataSource.getUser(email, password);
  //       userLocalDataSource.cacheUserData(remoteUser);
  //       return Right(remoteUser);
  //     } on ServerExeption {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localUser = await userLocalDataSource.saveUserSession();
  //       return Right(localUser);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
