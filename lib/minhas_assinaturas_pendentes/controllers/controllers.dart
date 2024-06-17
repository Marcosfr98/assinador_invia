import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';

import '../../notifications/services/flutter_local_notifications.dart';
import '../models/models.dart';

class MinhasAssinaturasPendentes {
  Future<List<MinhasAssinaturasPendentesModel>> getFluxos() async {
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    final payload = jsonEncode(
      {"apiPassword": "4pZqfXa3r88SW3aPr", "userCPF": "86521551000"},
    );
    final endpoint = Uri.parse(
        "https://invianf.com.br/ws/appAssinador/documentosAssinados.php");
    http.Response response =
        await http.post(endpoint, body: payload, headers: headers);
    if (response.statusCode == 200) {
      return List.generate(
        jsonDecode(response.body)["Results"].length,
        (index) => MinhasAssinaturasPendentesModel.fromJson(
          jsonDecode(response.body)["Results"][index],
        ),
      );
    } else {
      print(response.body);
    }
    return [];
  }

  Future<void> openLink({required String link}) async {
    try {
      await launchUrl(
        Uri.parse(link),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadDocumento(
      {required String url, required BuildContext context}) async {
    FileDownloader.downloadFile(
        url: url,
        name: "documento_assinado.pdf",
        onProgress: (String? fileName, double? progress) {
          print('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) async {
          await FlutterLocalNotifications().show(
              id: 0,
              title: "Download completo",
              body: "Arquivo baixado e salvo na pasta Downloads do dispositivo",
              payload: "");
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Erro ao baixar o arquivo!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
          print('DOWNLOAD ERROR: $error');
        });

    FileDownloader.setLogEnabled(true);

    FileDownloader.setMaximumParallelDownloads(10);
  }
}
