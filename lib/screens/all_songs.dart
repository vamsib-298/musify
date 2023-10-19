import 'dart:developer';

import 'package:Musify/screens/playing_song.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<SongModel> availableSongs = [];
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    requestPermission();
    getAvailableSongs();
  }

  Future<void> getAvailableSongs() async {
    availableSongs = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
  }

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log("Error Parsing Song");
    }
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    if (availableSongs.isEmpty) {
      getAvailableSongs();
    }

    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Musify'),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 228, 248, 6)),
        onSearch: (value) {
          setState(() {
            searchValue = value;
          });
        },
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (searchValue.isEmpty) {
            return ListTile(
              title: Text(availableSongs[index].displayNameWOExt),
              subtitle: Text("${availableSongs[index].artist}"),
              trailing: Icon(Icons.more_horiz),
              leading: QueryArtworkWidget(
                id: availableSongs[index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Image.asset('assets/images/musicfly.png'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NowPlaying(
                      songModel: availableSongs[index],
                      audioPlayer: _audioPlayer,
                    ),
                  ),
                );
              },
            );
          } else {
            // Filter the songs based on the search value
            if (availableSongs[index]
                .displayNameWOExt
                .toLowerCase()
                .contains(searchValue.toLowerCase())) {
              return ListTile(
                title: Text(availableSongs[index].displayNameWOExt),
                subtitle: Text("${availableSongs[index].artist}"),
                trailing: Icon(Icons.more_horiz),
                leading: QueryArtworkWidget(
                  id: availableSongs[index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Image.asset('assets/images/musicfly.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NowPlaying(
                        songModel: availableSongs[index],
                        audioPlayer: _audioPlayer,
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Container(); // Empty container to avoid rendering an error
        },
        itemCount: availableSongs.length,
      ),
    );
  }
}
