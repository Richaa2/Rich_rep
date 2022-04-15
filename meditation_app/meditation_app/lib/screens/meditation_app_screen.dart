import 'package:flutter/material.dart';
import 'package:meditation_app/models/item_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_libwinmedia/just_audio_libwinmedia.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MeditationAppScreen extends StatefulWidget {
  const MeditationAppScreen({Key? key}) : super(key: key);

  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {
  final List<Item> items = [
    Item(
      name: 'Forest',
      audioPath: 'meditation_audios/forest.mp3',
      imagePath: 'meditation_images/forest.jpeg',
    ),
    Item(
      name: 'Night',
      audioPath: 'meditation_audios/night.mp3',
      imagePath: 'meditation_images/night.jpeg',
    ),
    Item(
      name: 'Ocean',
      audioPath: 'meditation_audios/ocean.mp3',
      imagePath: 'meditation_images/ocean.jpeg',
    ),
    Item(
      name: 'Waterfall',
      audioPath: 'meditation_audios/waterfall.mp3',
      imagePath: 'meditation_images/waterfall.jpeg',
    ),
    Item(
      name: 'Wind',
      audioPath: 'meditation_audios/wind.mp3',
      imagePath: 'meditation_images/wind.jpeg',
    ),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(items[index].imagePath),
                ),
              ),
              height: 100,
              child: ListTile(
                title: Text(items[index].name),
                leading: IconButton(
                  icon: playingIndex == index
                      ? FaIcon(FontAwesomeIcons.stop)
                      : FaIcon(FontAwesomeIcons.play),
                  onPressed: () async {
                    if (playingIndex == index) {
                      setState(() {
                        playingIndex = null;
                      });
                      audioPlayer.stop();
                    } else {
                      try {
                        await audioPlayer.setAsset(items[index].audioPath);
                        //     .catchError((onError) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: Colors.red.withOpacity(0.5),
                        //       content: Text(
                        //         'oops... you have a problem',
                        //       ),
                        //     ),
                        //   );
                        // });

                        audioPlayer.play();
                        setState(() {
                          playingIndex = index;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
