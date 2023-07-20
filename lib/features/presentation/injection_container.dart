import 'package:bits_project/core/network/network_info.dart';
import 'package:bits_project/features/data/datasources/audio_remote_data_source.dart';
import 'package:bits_project/features/data/datasources/user_local_data_source.dart';
import 'package:bits_project/features/data/datasources/user_remote_data_source.dart';
import 'package:bits_project/features/data/repositories/audio_repository_impl.dart';
import 'package:bits_project/features/data/repositories/user_repository_impl.dart';
import 'package:bits_project/features/domain/repositories/audio_repository.dart';
import 'package:bits_project/features/domain/repositories/user_repository.dart';
import 'package:bits_project/features/domain/usecases/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  // sl.registerFactory(() => );

  //! Features
  sl.registerLazySingleton(() => GetUser(sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userRemoteDataSource: sl(),
      userLocalDataSource: sl(),
      networkInfo: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedpreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedpreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<AudioRepository>(
      () => AudioRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AudioRemoteDataSource>(
      () => AudioRemoteDataSourceImpl(client: sl()));
}
