import 'package:flutter/material.dart';

class MainScreenProvider extends ChangeNotifier {
  /// declare private variable
  int _pageIndex = 0;

  /// getter
  int get pageIndex => _pageIndex;

  /// setter
  set pageIndex(int newPageIndex) {
    _pageIndex = newPageIndex;
    notifyListeners();
  }
}
