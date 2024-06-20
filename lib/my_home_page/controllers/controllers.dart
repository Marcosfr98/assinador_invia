import 'package:flutter/cupertino.dart';

class MyHomePageController extends ChangeNotifier {
  bool _isFabOpened = false;

  bool get isFabOpened => _isFabOpened;

  void openCloseFab(bool value) {
    _isFabOpened = value;
    notifyListeners();
  }
}
