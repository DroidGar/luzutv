import 'package:flutter/material.dart';
import 'package:luzu/features/config_wrap.dart';
import 'package:luzu/features/home_page.dart';


class App extends StatelessWidget {

  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ConfigWrap(child: HomePage()),
    );
  }
}
