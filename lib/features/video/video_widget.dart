import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;

  const VideoWidget({super.key, required this.videoId});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        isLive: true,
        hideControls: false,
      ),
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
