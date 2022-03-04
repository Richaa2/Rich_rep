import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('list view build'),
          centerTitle: true,
        ),
        body: BodyListView(),
      ),
    );
  }
}

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  return ListView(
    itemExtent: 200,
    padding: EdgeInsets.all(8.0),
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      ListTile(
        title: Text('Sun'),
        subtitle: Text('Today clear'),
        leading: Icon(Icons.wb_sunny),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Cloudy'),
        subtitle: Text('Today Cloudy'),
        leading: Icon(Icons.wb_cloudy),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Rainy'),
        subtitle: Text('Today Rain'),
        leading: Icon(Icons.ac_unit),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    ],
  );
}
