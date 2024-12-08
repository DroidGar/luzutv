import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luzu/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:luzu/core/services/di_service.dart';
import 'package:luzu/core/services/router_service.dart';
import 'package:luzu/features/video/video_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

const host = 'https://api.luzutv.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final providers = [
    ChangeNotifierProvider(create: (_) => VideoProvider()),
  ];

  RouterService routerService = RouterService();

  await setUpDependencies();

  final app = App(
    routerService: routerService,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Set the status bar color to white
    statusBarIconBrightness:
        Brightness.dark, // Set the status bar icons to dark
  ));

  runApp(MultiProvider(providers: providers, child: app));
}
