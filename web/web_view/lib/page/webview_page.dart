import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: const WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'http://info.cern.ch',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(
          Icons.next_plan,
          size: 32,
        ),
      ),
    );
  }
}
