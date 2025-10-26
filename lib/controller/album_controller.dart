import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/repository/dal/album_dao.dart';

class Albumcontroller {
  const Albumcontroller();

  Future<List<Album>> readAll() async {
    AlbumDao albumDao = AlbumDao();
    return await albumDao.readAll();
  }

  Future<void> create(Album album) async {
    final Album albumFixed = Album(
      name: (album.name.isEmpty) ? "Other" : album.name,
    );

    AlbumDao albumDao = AlbumDao();
    await albumDao.create(albumFixed);
  }
}
