import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/repository/dal/link_dao.dart';

class LinkController {
  LinkController();

  Future<void> create(Link link) async {
    LinkDao linkDao = LinkDao();
    await linkDao.create(link);
  }

  Future<List<Link>> linksBySong(int songId) async {
    LinkDao linkDao = LinkDao();
    return await linkDao.linksBySong(songId);
  }
}
