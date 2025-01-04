import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  int _activePage = 0;
  List _shoeSizes = [];
  List _sizes=[];

  int get activePage => _activePage;

  List get shoeSizes => _shoeSizes;

  List get sizes => _sizes;

  set activePage(int newActivePage) {
    _activePage = newActivePage;
    notifyListeners();
  }

  set shoeSizes(List newShoeSize) {
    _shoeSizes = newShoeSize;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if(i == index){
        _shoeSizes[i]["isSelected"] = !_shoeSizes[i]["isSelected"];
      }
    }
    notifyListeners();
  }

  set sizes(List newSize){
    _sizes = newSize;
    notifyListeners();
  }
}
