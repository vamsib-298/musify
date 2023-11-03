import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTile extends StatelessWidget {
  final SongModel songModel;

  const MusicTile({
    required this.songModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        songModel.displayNameWOExt,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(songModel.additionalSongInfo),
      trailing: const Icon(Icons.more_horiz),
      leading: QueryArtworkWidget(
        id: songModel.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: const Icon(Icons.music_note),
      ),
    );
  }
}

extension ExtendedSongModel on SongModel {
  get additionalSongInfo {
    String artistInfo = artist.toString();
    String songTime = _millisToMinutesAndSeconds(duration);
    String artistName =
        artistInfo == "<unknown>" ? "Unknown Artist" : artistInfo;
    return "$artistName\t\t$songTime";
  }

  _millisToMinutesAndSeconds(millis) {
    int minutes = ((millis / 1000) / 60).toInt();
    int seconds = ((millis / 1000) % 60).toInt();
    return "$minutes:$seconds";
  }
}
