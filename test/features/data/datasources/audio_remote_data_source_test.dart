import 'dart:convert';

import 'package:bits_project/core/values/config.dart';
import 'package:bits_project/features/data/datasources/audio_remote_data_source.dart';
import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';

class MockAudioHttpClient extends Mock implements http.Client {}

void main() {
  late AudioRemoteDataSourceImpl dataSource;
  late MockAudioHttpClient mockAudioHttpClient;

  final audio = AudioModel(
      id: "6478d7e3972d87fd99b93223",
      audioName: "Vitamin D",
      imageLink: "VitaminD.png",
      audioLink: "VitaminD.wav",
      genre: "Pop",
      userId: "6478d743972d87fd99b93219",
      login: "Monatik");

  setUp(() {
    mockAudioHttpClient = MockAudioHttpClient();
    dataSource = AudioRemoteDataSourceImpl(client: mockAudioHttpClient);
    registerFallbackValue(Uri.parse(''));
  });

  void setUpMockHttpClientSuccess200Get() {
    when(() => mockAudioHttpClient
            .get(any(), headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response(fixture('audio.json'), 200));
  }

  void setUpMockHttpClientSuccess200Post() {
    when(() => mockAudioHttpClient.post(any(),
            body: any(named: 'body'),
            headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response(fixture('audio.json'), 200));
  }

  void setUpMockHttpClientFailure404Get() {
    when(() => mockAudioHttpClient
            .get(any(), headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure404Post() {
    when(() => mockAudioHttpClient.post(any(),
            body: any(named: 'body'),
            headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getAudio', () {
    test('should perform a Get request on a URL with genre for audio genre',
        () async {
      setUpMockHttpClientSuccess200Get();
      dataSource.getAudio();
      verify(() => mockAudioHttpClient
          .get(any(), headers: {'Content-Type': 'application/json'}));
    });

    test('should return audio when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200Get();

      final result = await dataSource.getAudio();

      expect(result, isInstanceOf<List<AudioModel>>());
    });
    test('should throw status.code when the response code is 404 or another',
        () async {
      setUpMockHttpClientFailure404Get();
      final call = dataSource.getAudio;
      expect(() => call(), throwsA(const TypeMatcher<int>()));
    });
  });
  group('sendAudio', () {
    test('should perform a Post request on a URL for audio', () {
      setUpMockHttpClientSuccess200Post();

      dataSource.sendAudio(audio);
      final audioMap = audio.toJson();
      verify(() => mockAudioHttpClient.post(Uri.parse('${getApiURl()}/upload'),
          body: json.encode(audioMap),
          headers: {'Content-Type': 'application/json'}));
    });
    test('should return Audio when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200Post();

      final result = await dataSource.sendAudio(audio);

      expect(result, isInstanceOf<bool>());
    });
    test('should throw status.code when the response code is 404 or another',
        () async {
      setUpMockHttpClientFailure404Post();
      final call = dataSource.sendAudio;
      expect(() => call(audio), throwsA(const TypeMatcher<int>()));
    });
  });
}
