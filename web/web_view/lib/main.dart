import 'package:flutter/material.dart';
import 'package:web_view/page/webview_local_page.dart';
import 'package:web_view/page/webview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const WebViewLocalPage(),
    );
  }
}
