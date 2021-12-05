import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//autor: Matěj Mudra
//
//
//
class Tabs with ChangeNotifier {
  int screenIndex = 0;
  bool isFarmer = false;

  int changeIndex(newIndex) {
    screenIndex = newIndex;
    if (screenIndex == 0) {
      isFarmer = true;
    } else if (screenIndex == 1) {
      isFarmer = false;
    }
    notifyListeners();
    return screenIndex;
  }

  int get getIndex {
    return screenIndex;
  }
}
