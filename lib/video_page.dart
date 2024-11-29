import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audio_service/audio_service.dart';
import 'package:luzu/video_provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: Provider.of<VideoProvider>(context, listen: false).videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, isLive: true),
    );
    _startAudioService();
  }

  void _startAudioService() {
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Video Player',
      androidNotificationColor: 0xFF2196F3,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    AudioService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoId = Provider.of<VideoProvider>(context).videoId;

    if (videoId.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Page'),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {
          // _controller.addListener(listener);
        },
      ),
    );
  }
}

void _audioPlayerTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    // Implement your audio player logic here
  }

  @override
  Future<void> onStop() async {
    // Implement your stop logic here
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    // Implement your play logic here
  }

  @override
  Future<void> onPause() async {
    // Implement your pause logic here
  }
}