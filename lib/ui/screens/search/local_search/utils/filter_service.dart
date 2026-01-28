import 'package:guitar_song_improvement/data/model/i_model.dart';

class SearchFilterUtils {
  static List<T> filter<T extends IModel>(List<T> items, String nameFilter) {
    List<T> filteredItems = [];
    nameFilter = nameFilter.toLowerCase();

    filteredItems = items
        .where((item) => item.name.toLowerCase().contains(nameFilter))
        .toList();

    return filteredItems;
  }
}
