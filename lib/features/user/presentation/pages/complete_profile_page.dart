import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompleteProfilePage extends StatelessWidget {
  static String routeName = '/complete-profile';
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller),
  }
}
