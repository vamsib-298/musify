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
  // Create an OnAudioQuery object to query for audio files on the device.
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Create an AudioPlayer object to play audio files.
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Create a list to store the available songs.
  List<SongModel> availableSongs = [];

  // Create a string variable to store the search value.
  String searchValue = '';

  // Initialize the state.
  @override
  void initState() {
    super.initState();
    requestPermission();
    getAvailableSongs();
  }

  // Request the storage permission.
  void requestPermission() {
    Permission.storage.request();
  }

  // Get the available songs from the device.
  Future<void> getAvailableSongs() async {
    availableSongs = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
  }

  // Play a song.
  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log("Error Parsing Song");
    }
  }

  // Build the widget.
  @override
  Widget build(BuildContext context) {
    // If the available songs list is empty, get the available songs.
    if (availableSongs.isEmpty) {
      getAvailableSongs();
    }

    // Return a Scaffold widget with an EasySearchBar app bar and a ListView body.
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
          // Filter the songs based on the search value.
          if (searchValue.isEmpty ||
              availableSongs[index]
                  .displayNameWOExt
                  .toLowerCase()
                  .contains(searchValue.toLowerCase())) {
            // Render a ListTile for each song.
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
                // Navigate to the NowPlaying screen when a song is tapped.
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
            // Render an empty container for the songs that don't match the search value.
            return Container();
          }
        },
        itemCount: availableSongs.length,
      ),
    );
  }
}
