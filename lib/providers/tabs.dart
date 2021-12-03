import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Tabs with ChangeNotifier {
  int _screenIndex = 0;
  bool isFarmer = false;

  void changeIndex(newIndex) {
    _screenIndex = newIndex;
    if (_screenIndex == 0) {
      isFarmer = true;
    } else if (_screenIndex == 1) {
      isFarmer = false;
    }
    notifyListeners();
  }

  int get getIndex {
    return _screenIndex;
  }
}
