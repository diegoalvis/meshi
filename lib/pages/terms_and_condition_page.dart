import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text("Terminos y condiciones"),
      ),
      body: WebView(
        initialUrl: "https://meshi-app.herokuapp.com/terms",
      ),
    );
  }
}