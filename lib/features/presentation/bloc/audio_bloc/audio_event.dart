abstract class AudioEvent {}

class FetchAudioEvent extends AudioEvent {
  String? genre;
  FetchAudioEvent({this.genre});
}
