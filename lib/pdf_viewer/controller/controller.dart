import 'dart:io';

import 'package:assinador_invia/notifications/services/flutter_local_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerControllerCustom {
  static Future<void> download(String url) async {
    FileDownloader.downloadFile(
        url: url,
        name: "THE FILE NAME AFTER DOWNLOADING",
        onProgress: (fileName, progress) {
          FirebaseCrashlytics.instance
              .log('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) async {
          await FlutterLocalNotifications().show(
              id: 0,
              title: "Documento baixado",
              body: "O documento foi salvo na pasta Downloads",
              payload: "{}");
          FirebaseCrashlytics.instance.log('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) async {
          try {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          } catch (e) {
            FirebaseCrashlytics.instance.log('DOWNLOAD ERROR: $e');
          }
          FirebaseCrashlytics.instance.log('DOWNLOAD ERROR: $error');
        });

    final List<File?> result = await FileDownloader.downloadFiles(urls: [
      'https://cdn.mos.cms.futurecdn.net/vChK6pTy3vN3KbYZ7UU7k3-320-80.jpg',
      'https://fansided.com/files/2015/10/cat.jpg',
    ], isParallel: true, onAllDownloaded: () {});
    FileDownloader.setLogEnabled(true);
    FileDownloader.setMaximumParallelDownloads(10);
  }
}
