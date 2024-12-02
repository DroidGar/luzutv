import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoId;
  const VideoPage({super.key, required this.videoId});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, isLive: true),
    );
  }


  @override
  Widget build(BuildContext context) {
    final videoView = YoutubePlayerBuilder(
      builder: (context, player) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: player,
        );
      },
      player: YoutubePlayer(
        aspectRatio: 16 / 9,
        controller: _controller,
        showVideoProgressIndicator: false,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        bottomActions: [],
        onReady: () {
          // _controller.addListener(listener);
        },

      ),
    );
    return videoView;
  }
}
