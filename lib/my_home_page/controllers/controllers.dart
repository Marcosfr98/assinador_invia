import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePageController extends ChangeNotifier {
  static MyHomePageController _instance = MyHomePageController();
  static MyHomePageController get instance => _instance;
  bool _isFabOpened = false;
  String _groupValueData = "";
  String _groupValueStatus = "";
  IconData _icon = FontAwesomeIcons.file;

  String get groupValueData => _groupValueData;
  String get groupValueStatus => _groupValueStatus;
  IconData get icon => _icon;

  bool get isFabOpened => _isFabOpened;

  void openCloseFab(bool value) {
    _isFabOpened = value;
    notifyListeners();
  }

  void changeIcon(IconData value) {
    _icon = value;
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
