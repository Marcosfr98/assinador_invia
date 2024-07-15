import 'package:flutter/cupertino.dart';

class MyLoginPageController extends ChangeNotifier {
  static MyLoginPageController get instance => _instance;
  static MyLoginPageController _instance = MyLoginPageController();

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  set isLoading(bool? value) {
    if (value != null) {
      _isLoading = value;
      notifyListeners();
    }
  }
}
