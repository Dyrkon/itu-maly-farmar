import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Tabs with ChangeNotifier {
  int screenIndex = 0;

  int changeIndex(newIndex) {
    screenIndex = newIndex;
    notifyListeners();
    return screenIndex;
  }

  int get getIndex {
    return screenIndex;
  }
}