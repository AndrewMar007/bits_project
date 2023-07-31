import 'package:bits_project/core/usecases/audiocase.dart';
import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:bits_project/features/domain/repositories/audio_repository.dart';

class AudioCase implements AudioUseCase {
  AudioRepository repository;
  AudioCase(this.repository);
  @override
  Future<List<AudioModel>?>? callGetAudio({String? genre}) {
    return repository.getAudio(genre: genre);
  }

  @override
  Future<bool?>? callSendAudio(AudioModel audio) {
    return repository.sendAudio(audio);
  }
}
