import 'package:flutter/material.dart';
/*
void main() {
  runApp(const MyApp(
    title: 'Musify',
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
  const MyHomePage(String s, {super.key, required String title});

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
*/

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('This is the home screen.'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('This is the settings screen.'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('This is the profile screen.'),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('This is the notifications screen.'),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
    ProfileScreen(),
    NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}
