import 'dart:convert';

import 'package:assinador_invia/my_home_page/models/fluxos_aguardando.dart';
import 'package:assinador_invia/my_home_page/models/fluxos_finalizados.dart';
import 'package:assinador_invia/my_home_page/models/fluxos_pendentes.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class MyHomePageApiServices extends ChangeNotifier {
  Future<List<FluxoAguardandoModel>> getFluxosAguardando() async {
    try {
      final endpoint = Uri.parse(
          'https://invianf.com.br/ws/appAssinador/aguardandoAssinatura.php');
      final payload = jsonEncode(
        {
          "apiPassword": "4pZqfXa3r88SW3aPr",
          "userCPF": "86521551000",
        },
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        final jsonObject = jsonDecode(response.body)["Results"];
        return jsonObject
            .map(
              (fluxo) => FluxoAguardandoModel.fromJson(fluxo),
            )
            .toList()
            .cast<FluxoAguardandoModel>();
      } else {
        print("Não foi possível recuperar os dados!");
      }
    } catch (e, stackTrace) {
      print("$e\n$stackTrace");
    }
    return [];
  }

  Future<List<FluxosPendentesModel>> getFluxosPendentes() async {
    try {
      final endpoint = Uri.parse(
          'https://invianf.com.br/ws/appAssinador/fluxosPendentes.php');
      final payload = jsonEncode(
        {"apiPassword": "4pZqfXa3r88SW3aPr", "idUser": 7},
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        final jsonObject = jsonDecode(response.body)["Results"];
        return jsonObject
            .map(
              (fluxo) => FluxosPendentesModel.fromJson(fluxo),
            )
            .toList()
            .cast<FluxosPendentesModel>();
      } else {
        print("Não foi possível recuperar os dados!");
      }
    } catch (e, stackTrace) {
      print("$e\n$stackTrace");
    }
    return [];
  }

  Future<List<FluxosFinalizadosModel>> getFluxosFinalizados() async {
    try {
      final endpoint = Uri.parse(
          'https://invianf.com.br/ws/appAssinador/fluxosFinalizados.php');
      final payload = jsonEncode(
        {"apiPassword": "4pZqfXa3r88SW3aPr", "idUser": "32"},
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        final jsonObject = jsonDecode(response.body)["Results"];
        return jsonObject
            .map(
              (fluxo) => FluxosFinalizadosModel.fromJson(fluxo),
            )
            .toList()
            .cast<FluxosFinalizadosModel>();
      } else {
        print("Não foi possível recuperar os dados!");
      }
    } catch (e, stackTrace) {
      print("$e\n$stackTrace");
    }
    return [];
  }
}
