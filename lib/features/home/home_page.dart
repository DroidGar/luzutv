import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:luzu/features/home/app_bar.dart';
import 'package:luzu/features/home/drawer.dart';
import 'package:luzu/features/survey/presentation/widgets/survey_widget.dart';
import 'package:luzu/features/video/video_widget.dart';
import 'package:luzu/features/video/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String title = 'En vivo';
  YoutubePlayerController? controller;
  final floating = Floating();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
  }

  @override
  Widget build(BuildContext context) {
    final videoId = Provider.of<VideoProvider>(context).videoId;
    if (videoId.isEmpty) {
      return const Text('No video selected');
    }

    final videoWidget = VideoWidget(
      videoId: videoId,
      onMetadataChange: (metadata) {
        title = metadata.title;
        if (title.isEmpty) {
          title = 'En vivo';
        }
        setState(() {});
      },
      onControllerLoad: (ctrl) {
        controller = ctrl;
      },
    );

    return PiPSwitcher(
      childWhenDisabled: Scaffold(
        endDrawer: drawer(context),
        body: body(videoWidget),
      ),
      childWhenEnabled: videoWidget,
    );
  }

  Widget body(videoWidget) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              MyAppBar(),
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: videoWidget,
              ),
              SizedBox(height: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 14),
              SurveyWidget(),
              ElevatedButton(
                onPressed: () {
                  // final floating = Floating();
                  // floating.isPipAvailable.then((isPipAvailable) async {
                  //   await floating.enable(const ImmediatePiP());
                  // });
                },
                child: const Text('Enable PiP'),
              ),
            ],
          ),
        ),
      );
}
