import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luzu/features/home/presentation/pages/home_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompleteProfilePage extends StatefulWidget {
  static String routeName = '/complete-profile';

  CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _controller = WebViewController();

  @override
  void initState() {
    super.initState();

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.dataFromString('''
        <html>
          <body>
            <h1>Complete Profile</h1>
            <p>Complete your profile to continue</p>
            <button onclick="callFlutterFunction()">Complete Profile</button>
            <script>
              function callFlutterFunction() {
                window.flutter.postMessage('completeProfile');
              }
            </script>
          </body>
        </html>
        ''', mimeType: 'text/html'),
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
