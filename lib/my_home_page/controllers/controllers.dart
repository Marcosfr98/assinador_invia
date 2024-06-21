import 'package:flutter/cupertino.dart';

class MyHomePageController extends ChangeNotifier {
  static MyHomePageController _instance = MyHomePageController();
  static MyHomePageController get instance => _instance;
  bool _isFabOpened = false;
  String _groupValueData = "";
  String _groupValueStatus = "";

  String get groupValueData => _groupValueData;
  String get groupValueStatus => _groupValueStatus;

  bool get isFabOpened => _isFabOpened;

  void openCloseFab(bool value) {
    _isFabOpened = value;
    notifyListeners();
  }

  void changeStatusFilter(String value) {
    _groupValueStatus = value;
    notifyListeners();
  }

  void changeDataFilter(String value) {
    _groupValueData = value;
    notifyListeners();
  }
}
