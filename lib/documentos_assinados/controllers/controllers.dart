import 'dart:convert';

import 'package:assinador_invia/documentos_assinados/models/models.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import "package:http/http.dart" as http;

class DocumentosAssinadosController {
  static Future<List<MeusDocumentosAssinados>> getDocumentos() async {
    try {
      final endpoint = Uri.parse(
          "https://invianf.com.br/ws/appAssinador/documentosAssinados.php");
      final payload = jsonEncode(
        {"apiPassword": "4pZqfXa3r88SW3aPr", "userCPF": "86521551000"},
      );
      http.Response response = await http.post(endpoint, body: payload);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["Results"]
            .map((item) => MeusDocumentosAssinados.fromJson(item))
            .toList()
            .cast<MeusDocumentosAssinados>();
      } else {}
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.log(
          "DocumentosAssinadosController.getDocumentos(): $e\n$stackTrace");
    }
    return [];
  }
}
