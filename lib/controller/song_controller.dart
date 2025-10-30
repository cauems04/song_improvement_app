import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/repository/dal/song_dao.dart';
import 'package:guitar_song_improvement/services/i_tunes_search_service.dart';

class Songcontroller {
  const Songcontroller();

  saveSong() {}

  Future<List<Song>> readAll() async {
    SongDao songDao = SongDao();
    return await songDao.readAll();
  }

  Future<void> create(Song song) async {
    final Song songFixed = Song(
      name: song.name,
      album: (song.album.isEmpty) ? "Other" : song.album,
      artist: (song.artist.isEmpty) ? "Unkown" : song.artist,
    );

    SongDao songDao = SongDao();
    await songDao.create(songFixed);
  }

  Future<void> delete(Song song) async {
    final Song songFixed = Song(
      name: song.name,
      album: (song.album.isEmpty) ? "Other" : song.album,
      artist: (song.artist.isEmpty) ? "Unkown" : song.artist,
    );

    SongDao songDao = SongDao();

    if (await songDao.exists(songFixed)) songDao.delete(songFixed);
  }

  Future<List<Song>> searchSongs(String parameter) async {
    List<Map<String, dynamic>> response = await ITunesSearchService.search(
      // Tentar mudar de dynamic pra object para melhor perform ance
      parameter,
    );

    List<Song> songs = [];
    for (Map<String, dynamic> songData in response) {
      songs.add(Song.fromJson(songData));
    }

    return songs;
  }

  Future<List<Song>> getSongsByAlbum(Album album) async {
    SongDao songDao = SongDao();
    List<Song> songs = await songDao.getSongsByAlbum(album);

    return songs;
  }

  Future<List<Song>> getSongsByArtist(Artist artist) async {
    SongDao songDao = SongDao();
    List<Song> songs = await songDao.getSongsByArtist(artist);

    return songs;
  }

  //Check if i'm using this function right here
  // filters
  List<Song> readFiltered(List<Song> songs, String filter) {
    return songs.where((song) => song.name.contains(filter)).toList();
  }

  // List<T> readFilt<T>(List<T> songs, String filter) {
  //   return songs.where((song) => song.name.contains(filter)).toList();
  // }

  //Following filters.....
}
