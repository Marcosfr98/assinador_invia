import 'package:flutter/cupertino.dart';

class MyLoginController extends ChangeNotifier {
  bool isObscure = true;

  void setIsObscure(bool value) {
    isObscure = value;
    notifyListeners();
  }
}
