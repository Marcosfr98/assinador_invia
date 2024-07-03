import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloaderService {
  static FileDownloaderService _instance = FileDownloaderService();

  static FileDownloaderService get instance => _instance;

  Future<String?> downloadFile(String? url) async {
    if (url != null && url.isNotEmpty) {
      var directory = await getDownloadPath();
      return await FlutterDownloader.enqueue(
          url: url,
          headers: {},
          savedDir: directory!,
          saveInPublicStorage: true,
          showNotification: true,
          openFileFromNotification: true,
          fileName: "${DateTime.now()}.pdf");
    }
    return null;
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path \n $stack");
    }
    return directory?.path;
  }
}
