import 'dart:convert';

import 'package:assinador_invia/my_home_page/models/type_variable.dart';
import 'package:assinador_invia/my_home_page/services/local_db.dart';
import 'package:assinador_invia/my_home_page/views/pages/pages.dart';
import 'package:assinador_invia/my_login_page/Models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class MyLoginServiceApi extends ChangeNotifier {
  static MyLoginServiceApi get instance => _instance;
  static MyLoginServiceApi _instance = MyLoginServiceApi();
  final _localPersistance = LocalPersistence.instance;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      final endpoint =
          Uri.parse("https://invianf.com.br/ws/appAssinador/login.php");
      final payload = jsonEncode({
        "apiPassword": "4pZqfXa3r88SW3aPr",
        "appUsername": username,
        "appPassword": password,
      });
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        await _localPersistance.setData(
            key: "isLoggedIn", value: true, type: TypeVariable.bool);
        await _localPersistance.setData(
            key: "usuarioLogado",
            value: jsonEncode(UsuarioModel.fromJson(jsonDecode(response.body))),
            type: TypeVariable.string);
        Get.offAll(() => MyHomePage(), transition: Transition.upToDown);
        print(response.body);
      } else if (response.statusCode != 200) {
        await EasyLoading.showError(
            "Erro ao fazer login!\nVerifique as credencias e tente novamente.");
      }
    }
  }
}
