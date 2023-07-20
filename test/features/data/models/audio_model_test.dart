import 'dart:convert';

import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:bits_project/features/domain/entities/audio_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final audioModel = AudioModel(
      id: "6478d7e3972d87fd99b93223",
      audioName: "Vitamin D",
      imageLink: "VitaminD.png",
      audioLink: "VitaminD.wav",
      genre: "Pop",
      userId: "6478d743972d87fd99b93219",
      login: "Monatik");
  test('shoul be a subclass of AudioEntity', () async {
    expect(audioModel, isA<AudioEntity>());
  });
  group('fromJson', () {
    test("Should return a valid AudioModel when we got JSON", () async {
      final Map<String, dynamic> decodeJson =
          json.decode(fixture('mock_audio.json'));

      final result = AudioModel.fromJson(decodeJson);
      expect(result, isInstanceOf<AudioModel>());
    });
  });

  group('toJson', () {
    test('', () {
      final result = audioModel.toJson();
      final expectedMap = {
        "_id": "6478d7e3972d87fd99b93223",
        "audioName": "Vitamin D",
        "imageLink": "VitaminD.png",
        "userId": "6478d743972d87fd99b93219",
        "genre": "Pop",
        "audioLink": "VitaminD.wav",
        "nickName": "Monatik"
      };
      expect(result, equals(expectedMap));
    });
  });
}
