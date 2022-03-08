import 'package:block_first/colors_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BLoC with Stream'),
          centerTitle: true,
        ),
        body: Center(
          child: StreamBuilder(
              stream: _bloc.outputStateStream,
              initialData: Colors.red,
              builder: (context, AsyncSnapshot<Color> snapshot) {
                return AnimatedContainer(
                  height: 100,
                  width: 100,
                  color: snapshot.data,
                  duration: Duration(milliseconds: 500),
                );
              }),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.event_red);
              },
              backgroundColor: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                _bloc.inputEventSink.add(ColorEvent.event_green);
              },
              backgroundColor: Colors.green,
            )
          ],
        ));
  }
}
