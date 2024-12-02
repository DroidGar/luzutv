import 'package:flutter/material.dart';
import 'package:luzu/app.dart';
import 'package:luzu/features/video_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final providers = [
    ChangeNotifierProvider(create: (_) => VideoProvider()),
  ];

  runApp(MultiProvider(providers: providers, child: const App()));
}
