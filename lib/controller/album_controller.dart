import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/repository/dal/album_dao.dart';

class AlbumController {
  const AlbumController();

  Future<List<Album>> readAll() async {
    AlbumDao albumDao = AlbumDao();
    return await albumDao.readAll();
  }

  Future<void> create(Album album) async {
    final Album albumFixed = Album(
      name: (album.name.isEmpty)
          ? "Other"
          : album
                .name, // Create a function on the album model to to this itself
    );

    AlbumDao albumDao = AlbumDao();

    final bool albumExists = await albumDao.exists(albumFixed);

    if (albumExists) return;

    await albumDao.create(albumFixed);
  }

  Future<void> delete(Album album) async {
    final Album albumFixed = Album(
      name: (album.name.isEmpty)
          ? "Other"
          : album
                .name, // Create a function on the album model to to this itself
    );

    AlbumDao albumDao = AlbumDao();

    if (await albumDao.exists(album)) {
      if (!(await albumDao.hasSongs(albumFixed))) {
        // Check where to use this function
        albumDao.delete(albumFixed);
      }
    }
  }
}
