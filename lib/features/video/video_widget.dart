import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;
  final Function(YoutubeMetaData) onMetadataChange;
  final Function(YoutubePlayerController) onControllerLoad;

  const VideoWidget({
    super.key,
    required this.videoId,
    required this.onMetadataChange,
    required this.onControllerLoad,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  YoutubeMetaData? _previousMetadata;

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

    _controller.addListener(() {
      if (_controller.value.isReady) {
        final currentMetadata = _controller.metadata;
        if (_previousMetadata == null || _previousMetadata != currentMetadata) {
          widget.onMetadataChange(currentMetadata);
          _previousMetadata = currentMetadata;
        }
      }
    });

    widget.onControllerLoad(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final videoView = YoutubePlayerBuilder(
      builder: (context, player) {
        return YoutubePlayer(aspectRatio: 16 / 9, controller: _controller);
      },
      player: YoutubePlayer(aspectRatio: 16 / 9, controller: _controller),
    );
    return videoView;
  }
}
