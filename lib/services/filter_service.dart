import 'package:guitar_song_improvement/model/i_model.dart';

class FilterService {
  static List<T> filter<T extends IModel>(List<T> items, String nameFilter) {
    List<T> filteredItems = [];
    nameFilter = nameFilter.toLowerCase();

    filteredItems = items
        .where((item) => item.name.toLowerCase().contains(nameFilter))
        .toList();

    return filteredItems;
  }
}
