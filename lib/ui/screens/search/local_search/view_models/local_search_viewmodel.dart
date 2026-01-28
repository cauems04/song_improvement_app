import 'package:flutter/material.dart';

enum FilterOptions { albums, artists, favorites }

class LocalSearchViewmodel {
  final ValueNotifier<FilterOptions?> currentFilter = ValueNotifier(null);

  void changeFilter(FilterOptions filter) {
    if (currentFilter.value == filter) {
      currentFilter.value = null;
      return;
    }

    currentFilter.value = filter;
  }
}
