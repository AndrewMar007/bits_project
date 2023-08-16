import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../domain/usecases/get_audio.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioCase getAudioUseCase;
  AudioBloc({required this.getAudioUseCase}) : super(AudioInitial()) {
    on<FetchAudioEvent>(_onFetchAudio);
  }

  _onFetchAudio(FetchAudioEvent event, Emitter<AudioState> emmit) async {
    emmit(AudioLoading());
    try {
      final result = await getAudioUseCase.callGetAudio(genre: event.genre);
      emmit(AudioLoadedWithSuccess(trackList: result));
    } catch (e) {
      emmit(AudioLoadedWithError(message: e.toString()));
    }
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'An unknown error has occured';
    }
  }
}
