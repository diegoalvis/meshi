import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("Terminos y condiciones"),
      ),
      url: "https://meshi-app.herokuapp.com/terms",
      hidden: true,
      initialChild: Center(child: CircularProgressIndicator()),
    );
  }
}
