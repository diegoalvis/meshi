import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class Term extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Text("Test"),
      ),
      body: WebView(
        initialUrl: "https://flutter.dev",
      ),
    );
  }
}