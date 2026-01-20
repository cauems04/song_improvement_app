import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/data/local/database/dao/link_dao.dart';

class LinkController {
  LinkController();

  Future<void> create(Link link) async {
    LinkDao linkDao = LinkDao();
    await linkDao.create(link);
  }

  Future<void> update(Link oldLink, Link newLink) async {
    LinkDao linkDao = LinkDao();
    await linkDao.update(oldLink, newLink);
  }

  Future<List<Link>> linksBySong(int songId) async {
    LinkDao linkDao = LinkDao();
    return await linkDao.linksBySong(songId);
  }

  Future<void> delete(int linkId) async {
    LinkDao linkDao = LinkDao();
    return await linkDao.delete(linkId);
  }
}
