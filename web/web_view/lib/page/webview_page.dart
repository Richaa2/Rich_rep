import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions {
  clearCache,
  clearCookies,
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webController;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Stay App\
        if (await _webController.canGoBack()) {
          _webController.goBack();
        } else {
          log('You are can`t go back');
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebView'),
          actions: [
            IconButton(
              onPressed: () async {
                if (await _webController.canGoBack()) {
                  _webController.goBack();
                } else {
                  log('You are can`t go back');
                }
                return;
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            IconButton(
              onPressed: () async {
                if (await _webController.canGoForward()) {
                  _webController.goForward();
                } else {
                  log('You are can`t go forward');
                }
                return;
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
            IconButton(
              onPressed: () async {
                _webController.reload();
              },
              icon: const Icon(Icons.replay),
            ),
            PopupMenuButton<MenuOptions>(
              onSelected: (value) {
                switch (value) {
                  case MenuOptions.clearCache:
                    _onClearCache(_webController, context);
                    break;
                  case MenuOptions.clearCookies:
                    _onClearCookies(context);
                    break;
                }
              },
              itemBuilder: (context) => <PopupMenuItem<MenuOptions>>[
                const PopupMenuItem(
                  value: MenuOptions.clearCache,
                  child: Text('clear cache'),
                ),
                const PopupMenuItem(
                  value: MenuOptions.clearCookies,
                  child: Text('clear cookies'),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: Colors.red,
              backgroundColor: Colors.black,
            ),
            Expanded(
              child: WebView(
                onWebViewCreated: (controller) {
                  _webController = controller;
                },
                onProgress: (progress) {
                  this.progress = progress / 100;
                  setState(() {});
                },
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://flutter.dev',
                onPageStarted: (url) {
                  log('new site: $url');
                },
                onPageFinished: (url) {
                  log('Page are downloaded');
                },
                navigationDelegate: (request) {
                  if (request.url.startsWith('https://m.youtube.com')) {
                    log('navigation is blocked to $request');
                    return NavigationDecision.prevent;
                  }
                  log('navigation allow to $request');
                  return NavigationDecision.navigate;
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final currentUrl = await _webController.currentUrl();
            log('previous site: $currentUrl');
            //_webController.loadUrl('https://www.youtube.com');
            _webController.evaluateJavascript(
              "document.getElementsByTagName('footer')[0].style.display='none'",
            );
          },
          child: const Icon(
            Icons.next_plan,
            size: 32,
          ),
        ),
      ),
    );
  }

  void _onClearCookies(BuildContext context) async {
    final bool hadCookies = await CookieManager().clearCookies();
    String message = 'Cookies deleted';

    if (!hadCookies) {
      message = 'Cookies has been deleted';
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _onClearCache(WebViewController controller, BuildContext context) async {
    await _webController.clearCache();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Cache deleted ')));
  }
}
