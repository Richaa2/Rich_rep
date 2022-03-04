import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'IndieFlower'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adding Assets'),
          centerTitle: true,
        ),
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/gg.jpg'),
              ),
              Image.asset('assets/icons/icon.png'),
              Positioned(
                top: 16,
                left: 115,
                child: Text(
                  'my custom font',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    // fontFamily: 'IndieFlower',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
