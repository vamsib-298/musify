import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musify/screens/PlayingSong.dart';
import 'package:musify/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

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
        title: '',
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
                icon: const Icon(Icons.home), title: const Text('')),
            BottomNavyBarItem(
                icon: const Icon(Icons.search), title: const Text('')),
            BottomNavyBarItem(
                icon: const Icon(Icons.library_add), title: const Text('')),
            BottomNavyBarItem(
                icon: const Icon(Icons.settings), title: const Text('')),
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

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log("Error Parsing Song" as num);
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Musify'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Center(child: Text('No Songs Found'));
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(item.data![index].displayNameWOExt),
              subtitle: Text("${item.data![index].artist}"),
              trailing: Icon(Icons.more_horiz),
              leading: const CircleAvatar(
                child: Icon(Icons.music_note),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NowPlaying(
                      songModel: item.data![index],
                      audioPlayer: _audioPlayer,
                    ),
                  ),
                );
              },
            ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
