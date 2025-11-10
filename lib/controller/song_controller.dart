import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/repository/dal/song_dao.dart';
import 'package:guitar_song_improvement/services/i_tunes_search_service.dart';

class SongController {
  const SongController();

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

  Future<Song> update(Song oldSong, Song newSong) async {
    final Song newSongFixed = Song(
      name: newSong.name,
      album: (newSong.album.isEmpty) ? "Other" : newSong.album,
      artist: (newSong.artist.isEmpty) ? "Unkown" : newSong.artist,
    );

    SongDao songDao = SongDao();

    bool exists = await songDao.exists(oldSong);
    print(
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    );
    print("Song exists: $exists");
    await songDao.update(oldSong, newSongFixed);
    return newSongFixed;
  }

  Future<void> delete(Song song) async {
    final Song songFixed = Song(
      id: song.id,
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
