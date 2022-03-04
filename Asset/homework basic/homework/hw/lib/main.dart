import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[300],
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Counter'),
          centerTitle: true,
        ),
        body: CounterWidget(),
      ),
    );
  }
}

int _count = 50;

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'tap \"-\" to decrement',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 145, left: 145, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _count -= 1;
                    });
                  },
                  icon: Icon(
                    Icons.remove,
                  ),
                ),
                Text(
                  '$_count',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _count += 1;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          const Text(
            'tap \"+\" to Increment bbb',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
