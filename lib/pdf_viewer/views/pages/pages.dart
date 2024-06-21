import "package:flutter/material.dart";
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
            child: Container(
              child: Center(
                child: ElevatedButton.icon(
                  icon: FaIcon(FontAwesomeIcons.share),
                  onPressed: () async {
                    try {
                      if (widget.url.isNotEmpty) {
                        await Share.shareUri(Uri.tryParse(widget.url)!);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  label: Text(
                    "Compartilhar",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
