import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Building loyouts'),
            centerTitle: true,
            backgroundColor: Colors.indigo,
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.access_alarm_sharp,
                size: 300,
                color: Colors.blue,
              ),
              Positioned(
                top: 200,
                left: 50,
                child: Text(
                  'alarm',
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
              )
            ],
          )
          //   Row(
          //   children: <Widget>[
          //     Expanded(
          //       flex: 2,
          //       child: Image.network(
          //           'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg'),
          //     ),
          //     Expanded(
          //       flex: 3,
          //       child: Container(
          //         color: Colors.red,
          //         padding: EdgeInsets.all(30),
          //         child: Text('1'),
          //       ),
          //     ),
          //     Expanded(
          //       flex: 2,
          //       child: Container(
          //         color: Colors.green,
          //         padding: EdgeInsets.all(30),
          //         child: Text('2'),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         color: Colors.blue,
          //         padding: EdgeInsets.all(30),
          //         child: Text('3'),
          //       ),
          //     ),
          //   ],

          //   // mainAxisAlignment: MainAxisAlignment.start,
          //   // children: <Widget>[
          //   //   Icon(Icons.adjust, size: 50, color: Colors.red),
          //   //   Icon(Icons.adjust, size: 50, color: Colors.green),
          //   //   Icon(Icons.adjust, size: 50, color: Colors.blue),
          //   //   Icon(Icons.adjust, size: 50, color: Colors.orange),
          //   // ],
          // )
          ),
      //  Container(
      //   decoration: BoxDecoration(
      //     color: Colors.amber,
      //     border: Border.all(),
      //   ),
      //   height: 100,
      //   width: 200,
      //   padding: EdgeInsets.all(10),
      //   margin: EdgeInsets.only(left: 40),
      //   alignment: Alignment.center,
      //   child: Text(
      //     'Hello Flutter',
      //     style: TextStyle(fontSize: 30),
      //   ),
      // Align(
      //   alignment: Alignment.center,
      //   child:

      // Padding(
      //   padding: EdgeInsets.only(left: 130, top: 300),
      //  child:
    );
  }
}
