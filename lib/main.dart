import 'package:Musify/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Musify",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(title: 'Musify'),
    );
  }
}
