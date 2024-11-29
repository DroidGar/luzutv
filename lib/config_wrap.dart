import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:luzu/video_provider.dart';

class ConfigWrap extends StatefulWidget {
  final Widget child;

  const ConfigWrap({super.key, required this.child});

  @override
  State<ConfigWrap> createState() => _ConfigWrapState();
}

class _ConfigWrapState extends State<ConfigWrap> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: stream, builder: builder);
  }

  Stream get stream => Stream.fromFuture(
        http.get(Uri.parse('https://api.luzutv.com/appConfig')),
      );

  get builder => (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final videoId = jsonDecode(snapshot.data.body)["videoId"];
        Provider.of<VideoProvider>(context, listen: false).setVideoId(videoId);
        return widget.child;
      };
}