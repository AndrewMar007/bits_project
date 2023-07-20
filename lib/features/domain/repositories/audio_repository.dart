import 'package:flutter/foundation.dart';

import '../../data/models/audio_model.dart';

abstract class AudioRepository with ChangeNotifier {
  Future<List<AudioModel>?>? getAudio({String? genre});
  Future<bool?>? sendAudio(AudioModel audio);

  List<AudioModel>? get audioItem;

  abstract bool isLoadingData;
}
