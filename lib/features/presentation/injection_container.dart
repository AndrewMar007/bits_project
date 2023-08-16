import 'package:bits_project/core/network/network_info.dart';
import 'package:bits_project/features/data/datasources/audio_remote_data_source.dart';
import 'package:bits_project/features/data/datasources/user_local_data_source.dart';
import 'package:bits_project/features/data/datasources/user_remote_data_source.dart';
import 'package:bits_project/features/data/repositories/audio_repository_impl.dart';
import 'package:bits_project/features/data/repositories/user_repository_impl.dart';
import 'package:bits_project/features/data/repositories/validation_repository_impl.dart';
import 'package:bits_project/features/domain/repositories/audio_repository.dart';
import 'package:bits_project/features/domain/repositories/user_repository.dart';
import 'package:bits_project/features/domain/repositories/validation_repository.dart';
import 'package:bits_project/features/domain/usecases/get_audio.dart';
import 'package:bits_project/features/domain/usecases/get_user.dart';
import 'package:bits_project/features/domain/usecases/send_user.dart';
import 'package:bits_project/features/domain/usecases/validate_email.dart';
import 'package:bits_project/features/domain/usecases/validate_password.dart';
import 'package:bits_project/features/presentation/bloc/audio_bloc/audio_bloc.dart';
import 'package:bits_project/features/presentation/bloc/validation_bloc/validation_event.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  // sl.registerFactory(() => );

  //! Features
  sl.registerLazySingleton(() => FetchUser(sl()));
  sl.registerLazySingleton(() => SendUser(sl()));
  sl.registerLazySingleton(() => AudioCase(sl()));
  sl.registerLazySingleton(() => ValidateEmail(repository: sl()));
  sl.registerLazySingleton(() => ValidatePassword(repository: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userRemoteDataSource: sl(),
      userLocalDataSource: sl(),
      networkInfo: sl()));

  sl.registerFactory(() => AudioBloc(getAudioUseCase: sl()));

  sl.registerLazySingleton<ValidationRepository>(
      () => ValidationRepositoryImpl());

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
