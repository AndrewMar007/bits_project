import 'package:equatable/equatable.dart';

import '../../data/models/audio_model.dart';

abstract class AudioState extends Equatable {}

class AudioInitial extends AudioState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AudioLoading extends AudioState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AudioLoadedWithSuccess extends AudioState {
  final List<AudioModel>? trackList;
  AudioLoadedWithSuccess({required this.trackList});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AudioLoadedWithError extends AudioState {
  final String message;
  AudioLoadedWithError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
