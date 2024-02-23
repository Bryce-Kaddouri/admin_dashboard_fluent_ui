import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool _isCollapsed = true;
  bool get isCollapsed => _isCollapsed;
  void setCollapsed(bool value) {
    _isCollapsed = value;
    notifyListeners();
  }

  bool _categoryIsCollapsed = true;
  bool get categoryIsCollapsed => _categoryIsCollapsed;
  void setCategoryCollapsed(bool value) {
    _categoryIsCollapsed = value;
    notifyListeners();
  }

  bool _productIsCollapsed = true;
  bool get productIsCollapsed => _productIsCollapsed;
  void setProductCollapsed(bool value) {
    _productIsCollapsed = value;
    notifyListeners();
  }

  bool _userIsCollapsed = true;
  bool get userIsCollapsed => _userIsCollapsed;
  void setUserCollapsed(bool value) {
    _userIsCollapsed = value;
    notifyListeners();
  }

  bool _bookIsCollapsed = true;
  bool get bookIsCollapsed => _bookIsCollapsed;
  void setBookCollapsed(bool value) {
    _bookIsCollapsed = value;
    notifyListeners();
  }
}
