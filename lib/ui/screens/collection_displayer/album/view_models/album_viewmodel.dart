import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/song.dart';

class AlbumViewmodel {
  late final Album album;

  final SongController _songController;

  AlbumViewmodel(this._songController);

  void initValues(Album album) {
    this.album = album;
  }

  Future<List<Song>> getSongs() async {
    return await _songController.getSongsByAlbum(album);
  }

  String get getInitials => album.name
      .trim()
      .split(" ")
      .where((text) => text.isNotEmpty)
      .take(2)
      .map((text) => text[0])
      .join()
      .toUpperCase();
}
