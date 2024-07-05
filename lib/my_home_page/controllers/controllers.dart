import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePageController extends ChangeNotifier {
  static MyHomePageController _instance = MyHomePageController();

  static MyHomePageController get instance => _instance;
  TextEditingController searchingController = TextEditingController();
  bool _isFabOpened = false;
  String _groupValueData = "Todos";
  String _groupValueStatus = "";
  bool _didType = false;
  bool _isSearching = false;
  String _search = "";
  IconData _icon = FontAwesomeIcons.file;
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _isFirstPage = true;
  bool _isLastPage = false;
  bool _filterRecents = true;
  int _currentIndex = 0;
  List<dynamic> _recentes = [];
  ScrollBehavior _scrollBehavior = ScrollBehavior().copyWith(
    physics: BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
  );

  ScrollBehavior get scrollBehavior => _scrollBehavior;

  List<dynamic> get recentes => _recentes;

  int get currentIndex => _currentIndex;

  String get groupValueData => _groupValueData;

  bool get isLoading => _isLoading;

  bool get filterRecents => _filterRecents;

  bool get isSuccess => _isSuccess;

  bool get didType => _didType;

  bool get isFirstPage => _isFirstPage;

  bool get isLastPage => _isLastPage;

  bool get isSearching => _isSearching;

  String get search => _search;

  String get groupValueStatus => _groupValueStatus;

  IconData get icon => _icon;

  bool get isFabOpened => _isFabOpened;

  void openCloseFab(bool value) {
    _isFabOpened = value;
    notifyListeners();
  }

  void changeCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void addDocumentoRecente(dynamic item) async {
    _recentes.add(item);
    notifyListeners();
  }

  void changeSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void changeScrollBehavior(ScrollBehavior value) {
    _scrollBehavior = value;
    notifyListeners();
  }

  void changeDidType(bool value) {
    _didType = value;
    notifyListeners();
  }

  void changeFilterRecent(bool value) {
    _filterRecents = value;
    notifyListeners();
  }

  void changeIsSuccess(bool value) {
    _isSuccess = value;
    notifyListeners();
  }

  void changeIsSeraching(bool value) {
    _isSearching = value;
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

  void changeIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeIsLastPage(bool value) {
    _isLastPage = value;
    notifyListeners();
  }

  void changeIsFirstPage(bool value) {
    _isFirstPage = value;
    notifyListeners();
  }

  void dismiss() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _instance.changeSearch("");
      _instance.changeIsSeraching(false);
      _instance.changeDidType(false);
      _instance.searchingController.clear();
      _instance.changeStatusFilter("");
      _instance.changeDataFilter("Todos");
      _instance.changeIsLoading(false);
      _instance.changeIsSuccess(false);
      _instance.changeIcon(
        FontAwesomeIcons.file,
      );
    });
  }
}
