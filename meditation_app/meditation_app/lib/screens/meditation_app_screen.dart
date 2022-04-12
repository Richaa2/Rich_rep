import 'package:flutter/material.dart';
import 'package:meditation_app/models/item_model.dart';

class MeditationAppScreen extends StatefulWidget {
  const MeditationAppScreen({Key? key}) : super(key: key);

  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {
  final List<Item> audioItems = [
    Item(
      name: 'Forest',
      imagePath: 'meditation_audios/forest.mp3',
      audioPath: 'meditation_images/forest.jpeg',
    ),
    Item(
      name: 'Night',
      imagePath: 'meditation_audios/night.mp3',
      audioPath: 'meditation_images/night.jpeg',
    ),
    Item(
      name: 'Ocean',
      imagePath: 'meditation_audios/ocean.mp3',
      audioPath: 'meditation_images/ocean.jpeg',
    ),
    Item(
      name: 'waterfall',
      imagePath: 'meditation_audios/waterfall.mp3',
      audioPath: 'meditation_images/waterfall.jpeg',
    ),
    Item(
      name: 'wind',
      imagePath: 'meditation_audios/wind.mp3',
      audioPath: 'meditation_images/wind.jpeg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container()),
    );
  }
}
