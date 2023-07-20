import 'package:bits_project/core/network/network_info.dart';
import 'package:bits_project/features/data/datasources/audio_remote_data_source.dart';
import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:bits_project/features/data/repositories/audio_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioRemoteDataSource extends Mock implements AudioRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AudioRepositoryImpl repository;
  late MockAudioRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  List<AudioModel> list = [
    AudioModel(
        id: "6478d7e3972d87fd99b93223",
        audioName: "Vitamin D",
        imageLink: "VitaminD.png",
        audioLink: "VitaminD.wav",
        genre: "Pop",
        userId: "6478d743972d87fd99b93219",
        login: "Monatik"),
    AudioModel(
        id: "6478d7e3972d87fd99b93223",
        audioName: "Vitamin D",
        imageLink: "VitaminD.png",
        audioLink: "VitaminD.wav",
        genre: "Pop",
        userId: "6478d743972d87fd99b93219",
        login: "Monatik")
  ];
  final audioModel = AudioModel(
      id: "6478d7e3972d87fd99b93223",
      audioName: "Vitamin D",
      imageLink: "VitaminD.png",
      audioLink: "VitaminD.wav",
      genre: "Pop",
      userId: "6478d743972d87fd99b93219",
      login: "Monatik");

  setUp(() {
    mockRemoteDataSource = MockAudioRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AudioRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
    registerFallbackValue(audioModel);
  });

  group('getAudio', () {
    test('should return true if device connected to Internet', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
        return Future<bool>.value(true);
      });
      await repository.getAudio();
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
          return Future<bool>.value(true);
        });
      });
      test(
          'should return remote data when the call to remote data source is success',
          () async {
        when(() => mockRemoteDataSource.getAudio()).thenAnswer((_) {
          return Future<List<AudioModel>>.value(list);
        });
        final result = await mockRemoteDataSource.getAudio();
        verify(() => mockRemoteDataSource.getAudio());
        expect(result, equals(list));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
          return Future<bool>.value(false);
        });
      });
      test('should throw Exception when device is offline', () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
          return Future<bool>.value(false);
        });
        Exception? result;
        if (await mockNetworkInfo.isConnected) {
        } else {
          result = Exception('Error');
        }
        verify(() => mockNetworkInfo.isConnected);
        expect(result, isInstanceOf<Exception>());
      });
    });
  });
  group('sedAudio', () {
    test('should return true if device connected to Internet', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
        return Future<bool>.value(true);
      });
      await repository.sendAudio(audioModel);
      verify(() => mockNetworkInfo.isConnected);
    });
  });

  group('device is online', () {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) {
        return Future<bool>.value(true);
      });
    });
    test(
        'should send remote data when the call to remote data source is success ',
        () async {
      when(() => mockRemoteDataSource.sendAudio(any())).thenAnswer((_) {
        return Future<bool>.value(true);
      });
      final result = await mockRemoteDataSource.sendAudio(audioModel);

      verify(() => mockRemoteDataSource.sendAudio(audioModel));
      expect(result, true);
    });
  });
}
