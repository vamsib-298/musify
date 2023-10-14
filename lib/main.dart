import 'dart:ffi';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:musify/splash_screen.dart';

void main() {
  runApp(const MyApp(
    title: '',
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(
        title: 'Welcome To Musify',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Void dispose() {
    _pageController.dispose();
    super.dispose();
    throw Exception();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Musify')),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Container(
                color: const Color.fromARGB(255, 8, 235, 43),
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.purpleAccent,
              ),
              Container(
                color: Colors.yellow,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: const Icon(Icons.home), title: const Text('Home')),
            BottomNavyBarItem(
                icon: const Icon(Icons.search), title: const Text('Search')),
            BottomNavyBarItem(
                icon: const Icon(Icons.library_add),
                title: const Text('Library')),
            BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings')),
          ],
          onItemSelected: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }
}
