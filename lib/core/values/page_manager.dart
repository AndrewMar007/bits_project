import 'package:audio_service/audio_service.dart';
import 'package:bits_project/features/presentation/pages/navigation/bottom_navigation_bar_pages.dart';
import 'package:flutter/foundation.dart';

import '../../features/data/models/audio_model.dart';
import '../../features/domain/usecases/get_audio.dart';
import '../../features/presentation/injection_container.dart' as di;
import '../../features/presentation/provider/notifiers/image_notifier.dart';
import '../../features/presentation/provider/notifiers/play_button_notifier.dart';
import '../../features/presentation/provider/notifiers/progress_notifier.dart';
import '../../features/presentation/provider/notifiers/repeat_button_notifier.dart';
import 'config.dart';

class PageManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final currentSongImageNotifier = ValueNotifier<String>('');

  final _audioHandler = di.sl<AudioHandler>();
  List<AudioModel>? _audioList;

  // Events: Calls coming from the UI
  void init() async {
    _loadPlaylist();
    _listenToPlaybackState();

    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  void setAudioList(List<AudioModel> audioList) {
    _audioList = audioList;
  }

  void _loadPlaylist() {
    // final songRepository = di.sl<AudioCase>();
    //final playlist = await songRepository.callGetAudio(genre: 'Pop');
    final playlist = _audioList;
    final mediaItems = playlist
        ?.map((song) => MediaItem(
              id: song.id!,
              title: song.audioName!,
              artUri: Uri.parse('${getApiURl()}/${song.imageLink}'),
              artist: song.login,
              genre: song.genre,
              extras: {
                'audioLink': '${getApiURl()}/${song.audioLink}',
                'userId': song.userId,
                'imageLink': '${getApiURl()}/${song.imageLink}'
              },
            ))
        .toList();
    _audioHandler.addQueueItems(mediaItems!);
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongImageNotifier.value = mediaItem?.extras!['imageLink'] ?? '';
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      print("Current song title" + currentSongTitleNotifier.value);
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  // Future<void> add() async {
  //   final songRepository = getIt<PlaylistRepository>();
  //   final song = await songRepository.fetchAnotherSong();
  //   final mediaItem = MediaItem(
  //     id: song['id'] ?? '',
  //     album: song['album'] ?? '',
  //     title: song['title'] ?? '',
  //     extras: {'url': song['url']},
  //   );
  //   _audioHandler.addQueueItem(mediaItem);
  // }
  void start(int index) {
    _audioHandler.skipToQueueItem(index);
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
