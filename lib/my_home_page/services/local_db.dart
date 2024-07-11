import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/type_variable.dart';

class LocalPersistence extends ChangeNotifier {
  SharedPreferences? _prefs;

  static LocalPersistence get instance => _instance;
  static LocalPersistence _instance = LocalPersistence();

  Future<bool> initialize() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      return true;
    }
    return false;
  }

  Future<bool> setData({required String key, required dynamic value, required String type}) async {
    if (_prefs != null) {
      if (type == TypeVariable.string) {
        await _prefs!.setString(key, value);
        return true;
      } else if (type == TypeVariable.bool) {
        await _prefs!.setBool(key, value);
        return true;
      } else if (type == TypeVariable.stringList) {
        await _prefs!.setStringList(key, value);
        return true;
      } else {
        await _prefs!.setInt(key, value);
        return true;
      }
    }
    return false;
  }

  Future<dynamic> getData({required String key, required String type}) async {
    if (_prefs != null) {
      if (type == TypeVariable.string) {
        return await _prefs!.getString(key);
      } else if (type == TypeVariable.stringList) {
        return await _prefs!.getStringList(key);
      } else if (type == TypeVariable.int) {
        return await _prefs!.getInt(key);
      } else {
        return await _prefs!.getBool(key);
      }
    }
    return false;
  }
}
