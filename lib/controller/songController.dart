import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/services/i_tunes_search_service.dart';

class Songcontroller {
  const Songcontroller();

  saveSong() {}

  Future<List<Song>> searchSongs(String parameter) async {
    List<Map<String, dynamic>> response = await ITunesSearchService.search(
      // Tentar mudar de dynamic pra object para melhor performance
      parameter,
    );

    List<Song> songs = [];
    for (Map<String, dynamic> songData in response) {
      Song currentSong = Song.fromJson(songData);

      songs.add(currentSong);
    }

    return songs;
  }
}
