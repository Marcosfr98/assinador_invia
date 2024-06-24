import "dart:io";

import "package:assinador_invia/services/notifications.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:share_plus/share_plus.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

class PdfViewer extends StatefulWidget {
  final String url;
  const PdfViewer({super.key, required this.url});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  double _downloadProgress = 0.0;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Visualizar documento",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Builder(
              builder: (context) {
                if (widget.url.isNotEmpty) {
                  return SfPdfViewer.network(widget.url);
                } else {
                  return Center(
                    child: Text("Url inválida!"),
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: Center(
                    child: ElevatedButton.icon(
                      label: FaIcon(FontAwesomeIcons.share),
                      onPressed: () async {
                        try {
                          if (widget.url.isNotEmpty) {
                            await Share.shareUri(Uri.tryParse(widget.url)!);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: Center(
                    child: ElevatedButton.icon(
                      label: _isLoading
                          ? CircularProgressIndicator(
                              value: _downloadProgress / 100,
                              backgroundColor: Colors.blueAccent,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : FaIcon(FontAwesomeIcons.download),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final File? file = await FileDownloader.downloadFile(
                            url: widget.url,
                            name: "documento.pdf",
                            onProgress: (String? fileName, double progress) {
                              setState(() {
                                _downloadProgress = progress;
                              });
                            },
                            onDownloadCompleted: (fileName) async {
                              setState(() {
                                _isLoading = false;
                              });
                              await LocalNotificationsService.instance
                                  .showNotification(
                                      0,
                                      "Documento baixado com sucesso!",
                                      "Documento está localizado na pasta Downloads do dispositivo.",
                                      "payload");
                            },
                            onDownloadError: (error) async {
                              await EasyLoading.showToast(
                                  "Erro ao baixar documento!");
                              setState(() {
                                _isLoading = false;
                              });
                              print(error);
                            });

                        print('FILE: ${file?.path}');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
