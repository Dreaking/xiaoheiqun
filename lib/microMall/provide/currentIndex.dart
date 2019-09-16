import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;
  bool search = false;
  int productCounts = 1;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  searchIndex(bool newIndex) {
    search = newIndex;
    notifyListeners();
  }

  /*
  **商品详情页面数据
   */
  setProductCounts() {
    productCounts = 1;
    notifyListeners();
  }

  //商品的数量添加
  addProducts() {
    productCounts++;
    notifyListeners();
  }

  //商品的数量减少
  delProducts() {
    if (productCounts > 0) {
      productCounts--;
      notifyListeners();
    }
  }
}
