import 'package:flutter/material.dart';

class VideoProvider with ChangeNotifier {
  String _videoId = '';

  String get videoId => _videoId;

  void setVideoId(String id) {
    _videoId = id;
    notifyListeners();
  }
}