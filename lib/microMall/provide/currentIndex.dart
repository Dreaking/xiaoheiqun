import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;
  bool search = false;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  searchIndex(bool newIndex) {
    search = newIndex;
    notifyListeners();
  }
}
