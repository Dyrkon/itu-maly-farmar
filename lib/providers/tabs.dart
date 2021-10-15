import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Tabs with ChangeNotifier {
  int index = 0;

  int changeIndex(newIndex) {
    index = newIndex;
    return index;
    notifyListeners();
  }
}