import 'package:bits_project/features/data/datasources/audio_remote_data_source.dart';
import 'package:bits_project/features/data/models/audio_model.dart';
import 'package:bits_project/features/domain/repositories/audio_repository.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/network_info.dart';

class AudioRepositoryImpl with ChangeNotifier implements AudioRepository {
  AudioRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  List<AudioModel>? listAudio;
  @override
  bool isLoadingData = false;

  AudioRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<List<AudioModel>?>? getAudio({String? genre}) async {
    isLoadingData = true;
    if (await networkInfo.isConnected) {
      listAudio = await remoteDataSource.getAudio(genre: genre);
      // List<AudioModel>? remoteAudio = await remoteDataSource.getAudio();
      // return remoteAudio;
      notifyListeners();
      isLoadingData = false;
      return listAudio;
    } else {
      throw Exception("Unhandled Exception");
    }
  }

  @override
  List<AudioModel>? get audioItem {
    return listAudio;
  }

  @override
  Future<bool?>? sendAudio(AudioModel audio) async {
    if (await networkInfo.isConnected) {
      bool? sendAudioToRemote = await remoteDataSource.sendAudio(audio);
      notifyListeners();
      return sendAudioToRemote;
    } else {
      throw Exception("Unhandled Exception");
    }
  }
}
