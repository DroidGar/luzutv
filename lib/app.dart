import 'package:flutter/material.dart';
import 'package:luzu/core/services/router_service.dart';
import 'package:luzu/core/services/theme_service.dart';

class App extends StatelessWidget {
  final RouterService routerService;

  const App({super.key, required this.routerService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: routerService.router,
    );
  }
}
