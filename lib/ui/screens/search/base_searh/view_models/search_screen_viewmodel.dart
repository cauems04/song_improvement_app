import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';

enum SearchOptions { onlineSearch, localSearch }

class SearchViewmodel extends ChangeNotifier {
  final SongController songController;

  late String _search;
  SearchOptions _currentPageIndex = SearchOptions.onlineSearch;

  SearchViewmodel(this.songController);

  void intitValues(String search) {
    _search = search;
  }

  String get search => _search;
  set setSearch(String value) {
    if (value != search) {
      _search = value;
      notifyListeners();
    }
  }

  set setLocalSearch(String value) {
    if (currentPage == SearchOptions.localSearch) {
      _search = value;
      notifyListeners();
    }
  }

  SearchOptions get currentPage => _currentPageIndex;
  set setCurrentPage(int index) {
    _currentPageIndex = SearchOptions.values[index];
    notifyListeners();
  }
}
