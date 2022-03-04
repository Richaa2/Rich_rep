import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Color _color =
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      height: 200.0,
      width: 200.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _color ==
                    Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1.0)
                ? _color =
                    Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1.0)
                : _color =
                    Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1.0);
          });
        },
      ),
    );
  }
}
