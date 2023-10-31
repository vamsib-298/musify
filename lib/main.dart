import 'package:flutter/material.dart';
import 'package:musify/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musify',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(title: 'Musify'),
    );
  }
}
