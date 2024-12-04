import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:luzu/features/video/video_widget.dart';
import 'package:luzu/features/video/video_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final videoId = Provider.of<VideoProvider>(context).videoId;
    if (videoId.isEmpty) {
      return const Text('No video selected');
    }

    final videoWidget = VideoWidget(videoId: videoId);

    return PiPSwitcher(
      childWhenDisabled: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/logo.png'),
        ),
        body: Column(
          children: [
            videoWidget,
            ElevatedButton(
              onPressed: () {
                final floating = Floating();
                floating.isPipAvailable.then((isPipAvailable) async {
                  await floating.enable(const ImmediatePiP());
                });
              },
              child: const Text('Enable PiP'),
            ),
          ],
        ),
      ),
      childWhenEnabled: videoWidget,
    );
  }
}
