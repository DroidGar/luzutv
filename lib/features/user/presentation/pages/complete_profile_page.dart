import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/features/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompleteProfilePage extends StatefulWidget {
  static String routeName = '/complete-profile';

  CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _controller = WebViewController();
  final sharedPref = getIt<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    final token = _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://api.luzutv.com/user_update_form'),
        headers: {'x-authorization': '${sharedPref.getString('token')}'},
      )
      ..addJavaScriptChannel(
        'flutter',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'completeProfile') {
            _completeProfile();
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 50),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }

  void _completeProfile() {
    context.go(HomePage.routeName);
  }
}
