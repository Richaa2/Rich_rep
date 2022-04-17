import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test1/notifier/progress_notifier.dart';

import 'notifier/play_button_notifier.dart';

class PageManager {
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final progressNotifier =
      ValueNotifier<ProgressBarState>(const ProgressBarState(
    current: Duration.zero,
    buffered: Duration.zero,
    total: Duration.zero,
  ));
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  // static const url =
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  PageManager() {
    _init();
  }
  void _init() async {
    _audioPlayer = AudioPlayer();
    _setInitialPlaylist();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  // TODO: set playlist
  // void _setInitialPlaylist() async {
  //   const url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
  //   await _audioPlayer.setUrl(url);
  // }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: const Duration(minutes: 1, seconds: 30),
      );
    });
  }

  void _setInitialPlaylist() async {
    const prefix = 'https://www.soundhelix.com/examples/mp3';
    final song1 = Uri.parse('$prefix/SoundHelix-Song-1.mp3');
    final song2 = Uri.parse('$prefix/SoundHelix-Song-2.mp3');
    final song3 = Uri.parse('$prefix/SoundHelix-Song-3.mp3');
    _playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(song1, tag: 'Cha Cha Cha'),
      AudioSource.uri(song2, tag: 'Samba'),
      AudioSource.uri(song3, tag: 'Rumba'),
    ]);
    await _audioPlayer.setAudioSource(_playlist);
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      // TODO: update current song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String?;
      currentSongTitleNotifier.value = title ?? '';
      // TODO: update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // TODO: update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }
  // void onRepeatButtonPressed() {
  //   // TODO
  // }

  void onPreviousSongButtonPressed() {
    // TODO
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    // TODO
    _audioPlayer.seekToNext();
    // }

    // void onShuffleButtonPressed() async {
    //   // TODO
    // }

    // void addSong() {
    //   // TODO
    // }

    // void removeSong() {
    //   // TODO
    // }
  }
}
// class SequenceState {
//   late final List<IndexedAudioSource> sequence;
//   late final int currentIndex;
//   // final List<int> shuffleIndices;
//   // final bool shuffleModeEnabled;
//   // final LoopMode loopMode;
//   IndexedAudioSource? get currentSource => ...;
//   List<IndexedAudioSource> get effectiveSequence => ...;
// }