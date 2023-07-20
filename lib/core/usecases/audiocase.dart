import 'package:bits_project/features/data/models/audio_model.dart';

abstract class AudioUseCase<Type> {
  Future<Type?>? callGetAudio({String? genre});

  Future<Type?>? callSendAudio(AudioModel audio);
}
