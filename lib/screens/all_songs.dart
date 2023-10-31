import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variable
  Color bgColor = Color.fromARGB(255, 177, 229, 20);
  //player
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: bgColor,
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
        // future: rootBundle.loadString("AssetManifest.json"),
        builder: (context, item) {
          if (item.hasData) {
            Map? jsonMap = json.decode(item.data!);
            // List? songs = jsonMap?.keys.toList();
            List? songs = jsonMap?.keys
                .where((element) => element.endsWith(".mp3"))
                .toList();

            return ListView.builder(
              itemCount: songs?.length,
              itemBuilder: (context, index) {
                var path = songs![index].toString();
                var title =
                    path.split("assets/songs/").last.toString(); //get file name
                title = title.replaceAll("%20", ""); //remove %20 characters
                title = title.split(".").first;

                return Container(
                  margin:
                      const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color: Color.fromARGB(179, 0, 0, 0),
                        width: 3.0,
                        style: BorderStyle.solid),
                  ),
                  child: ListTile(
                    textColor: Color.fromARGB(255, 0, 0, 0),
                    title: Text(title),
                    subtitle: Text(
                      " $path",
                      style: const TextStyle(
                          color: Color.fromARGB(179, 26, 203, 206),
                          fontSize: 13),
                    ),
                    leading: const Icon(
                      Icons.audiotrack,
                      size: 33,
                      color: Color.fromARGB(179, 255, 3, 3),
                    ),
                    onTap: () async {
                      toast(context, "Playing: $title");
                      //play this song
                      await _player.setAsset(path);
                      await _player.play();
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Songs in the Assets"),
            );
          }
        },
      ),
    );
  }

  //A toast method
  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }
}
