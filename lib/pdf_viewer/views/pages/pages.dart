import "package:flutter/material.dart";
import "package:flutter_downloader/flutter_downloader.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:path_provider/path_provider.dart";
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
        actions: [
          IconButton(
            onPressed: () async {
              try {
                if (widget.url.isNotEmpty) {
                  await Share.shareUri(Uri.tryParse(widget.url)!);
                }
              } catch (e) {
                print(e);
              }
            },
            icon: FaIcon(FontAwesomeIcons.share),
          ),
          IconButton(
            onPressed: () async {
              if (widget.url.isNotEmpty) {
                setState(() {
                  _isLoading = true;
                });
                try {
                  var path = await getApplicationDocumentsDirectory();
                  print(path.absolute.path);
                  await FlutterDownloader.enqueue(
                      url: widget.url, savedDir: path.absolute.path);
                } catch (e, stack) {
                  print("$e\n$stack");
                }
                setState(() {
                  _isLoading = false;
                });
              }
            },
            icon: _isLoading
                ? CircularProgressIndicator(
                    value: _downloadProgress / 100,
                    backgroundColor: Colors.blueAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : FaIcon(FontAwesomeIcons.download),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          if (widget.url.isNotEmpty) {
            return SfPdfViewer.network(
              widget.url,
            );
          } else {
            return Center(
              child: Text("Url inválida!"),
            );
          }
        },
      ),
    );
  }
}
