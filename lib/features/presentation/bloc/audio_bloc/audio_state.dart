import 'package:equatable/equatable.dart';

import '../../../data/models/audio_model.dart';

abstract class AudioState extends Equatable {}

class AudioInitial extends AudioState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AudioLoading extends AudioState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AudioLoadedWithSuccess extends AudioState {
  final List<AudioModel>? trackList;
  AudioLoadedWithSuccess({required this.trackList});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AudioLoadedWithError extends AudioState {
  final String message;
  AudioLoadedWithError({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
