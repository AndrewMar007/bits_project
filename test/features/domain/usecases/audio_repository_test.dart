import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:bits_project/features/domain/repositories/audio_repository.dart';
import 'package:bits_project/features/domain/usecases/get_audio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioRepository extends Mock implements AudioRepository {}

void main() {
  AudioCase? useCase;
  MockAudioRepository? repository;
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
    repository = MockAudioRepository();
    useCase = AudioCase(repository: repository!);
    registerFallbackValue(audioModel);
  });

  test("should get audio data for user request", () async {
    when(() => repository!.getAudio()).thenAnswer((_) {
      return Future<List<AudioModel>>.value(list);
    });
    final result = await useCase!.callGetAudio();
    expect(result, list);
    verify(() => repository!.getAudio());
    verifyNoMoreInteractions(repository);
  });
  test('should send audio data for user response', () async {
    when(() => repository!.sendAudio(any())).thenAnswer((_) async {
      return Future<bool>.value(true);
    });
    final result = await useCase!.callSendAudio(audioModel);
    expect(result, true);
    verify(() => repository!.sendAudio(audioModel));
    verifyNoMoreInteractions(repository);
  });
}
