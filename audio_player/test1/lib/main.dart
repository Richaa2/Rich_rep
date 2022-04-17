import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:test1/notifier/play_button_notifier.dart';
import 'notifier/progress_notifier.dart';
import 'page_manager.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// use GetIt or Provider rather than a global variable in a real project
late final PageManager _pageManager;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CurrentSongTitle(),
              Playlist(),
              //AddRemoveSongButtons(),
              AudioProgressBar(),
              AudioControlButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(fontSize: 40)),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${playlistTitles[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}

// class AddRemoveSongButtons extends StatelessWidget {
//   const AddRemoveSongButtons({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: _pageManager.addSong,
//             child: Icon(Icons.add),
//           ),
//           FloatingActionButton(
//             onPressed: _pageManager.removeSong,
//             child: Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          //ShuffleButton(),
        ],
      ),
    );
  }
}

// class RepeatButton extends StatelessWidget {
//   const RepeatButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<RepeatState>(
//       valueListenable: _pageManager.repeatButtonNotifier,
//       builder: (context, value, child) {
//         Icon icon;
//         switch (value) {
//           case RepeatState.off:
//             icon = Icon(Icons.repeat, color: Colors.grey);
//             break;
//           case RepeatState.repeatSong:
//             icon = Icon(Icons.repeat_one);
//             break;
//           case RepeatState.repeatPlaylist:
//             icon = Icon(Icons.repeat);
//             break;
//         }
//         return IconButton(
//           icon: icon,
//           onPressed: _pageManager.onRepeatButtonPressed,
//         );
//       },
//     );
//   }
// }

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed:
              (isFirst) ? null : _pageManager.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (isLast) ? null : _pageManager.onNextSongButtonPressed,
        );
      },
    );
  }
}

// class ShuffleButton extends StatelessWidget {
//   const ShuffleButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _pageManager.isShuffleModeEnabledNotifier,
//       builder: (context, isEnabled, child) {
//         return IconButton(
//           icon: (isEnabled)
//               ? Icon(Icons.shuffle)
//               : Icon(Icons.shuffle, color: Colors.grey),
//           onPressed: _pageManager.onShuffleButtonPressed,
//         );
//       },
//     );
//   }
// }






















// // This is a minimal example demonstrating a play/pause button and a seek bar.
// // More advanced examples demonstrating other features can be found in the same
// // directory as this example in the GitHub repository.

// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:test1/common.dart';
// import 'package:rxdart/rxdart.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   final _player = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addObserver(this);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//     ));
//     _init();
//   }

//   Future<void> _init() async {
//     // Inform the operating system of our app's audio attributes etc.
//     // We pick a reasonable default for an app that plays speech.
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration.speech());
//     // Listen to errors during playback.
//     _player.playbackEventStream.listen((event) {},
//         onError: (Object e, StackTrace stackTrace) {
//       print('A stream error occurred: $e');
//     });
//     // Try to load audio from a source and catch any errors.
//     try {
//       await _player.setAudioSource(AudioSource.uri(Uri.parse(
//           "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
//     } catch (e) {
//       print("Error loading audio source: $e");
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance?.removeObserver(this);
//     // Release decoders and buffers back to the operating system making them
//     // available for other apps to use.
//     _player.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // Release the player's resources when not in use. We use "stop" so that
//       // if the app resumes later, it will still remember what position to
//       // resume from.
//       _player.stop();
//     }
//   }

//   /// Collects the data useful for displaying in a seek bar, using a handy
//   /// feature of rx_dart to combine the 3 streams of interest into one.
//   Stream<PositionData> get _positionDataStream =>
//       Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//           _player.positionStream,
//           _player.bufferedPositionStream,
//           _player.durationStream,
//           (position, bufferedPosition, duration) => PositionData(
//               position, bufferedPosition, duration ?? Duration.zero));

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Display play/pause button and volume/speed sliders.
//               ControlButtons(_player),
//               // Display seek bar. Using StreamBuilder, this widget rebuilds
//               // each time the position, buffered position or duration changes.
//               StreamBuilder<PositionData>(
//                 stream: _positionDataStream,
//                 builder: (context, snapshot) {
//                   final positionData = snapshot.data;
//                   return SeekBar(
//                     duration: positionData?.duration ?? Duration.zero,
//                     position: positionData?.position ?? Duration.zero,
//                     bufferedPosition:
//                         positionData?.bufferedPosition ?? Duration.zero,
//                     onChangeEnd: _player.seek,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Displays the play/pause button and volume/speed sliders.
// class ControlButtons extends StatelessWidget {
//   final AudioPlayer player;

//   ControlButtons(this.player);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Opens volume slider dialog
//         IconButton(
//           icon: Icon(Icons.volume_up),
//           onPressed: () {
//             showSliderDialog(
//               context: context,
//               title: "Adjust volume",
//               divisions: 10,
//               min: 0.0,
//               max: 1.0,
//               value: player.volume,
//               stream: player.volumeStream,
//               onChanged: player.setVolume,
//             );
//           },
//         ),

//         /// This StreamBuilder rebuilds whenever the player state changes, which
//         /// includes the playing/paused state and also the
//         /// loading/buffering/ready state. Depending on the state we show the
//         /// appropriate button or loading indicator.
//         StreamBuilder<PlayerState>(
//           stream: player.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (processingState == ProcessingState.loading ||
//                 processingState == ProcessingState.buffering) {
//               return Container(
//                 margin: EdgeInsets.all(8.0),
//                 width: 64.0,
//                 height: 64.0,
//                 child: CircularProgressIndicator(),
//               );
//             } else if (playing != true) {
//               return IconButton(
//                 icon: Icon(Icons.play_arrow),
//                 iconSize: 64.0,
//                 onPressed: player.play,
//               );
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                 icon: Icon(Icons.pause),
//                 iconSize: 64.0,
//                 onPressed: player.pause,
//               );
//             } else {
//               return IconButton(
//                 icon: Icon(Icons.replay),
//                 iconSize: 64.0,
//                 onPressed: () => player.seek(Duration.zero),
//               );
//             }
//           },
//         ),
//         // Opens speed slider dialog
//         StreamBuilder<double>(
//           stream: player.speedStream,
//           builder: (context, snapshot) => IconButton(
//             icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             onPressed: () {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust speed",
//                 divisions: 10,
//                 min: 0.5,
//                 max: 1.5,
//                 value: player.speed,
//                 stream: player.speedStream,
//                 onChanged: player.setSpeed,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
