import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:meshi/utils/localiztions.dart';

const String URL_TERMS_AND_CONDITIONS = "https://meshi-app.herokuapp.com/terms";

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(strings.termsAndConditions),
      ),
      url: URL_TERMS_AND_CONDITIONS,
      hidden: true,
      initialChild: Center(child: CircularProgressIndicator()),
    );
  }
}
