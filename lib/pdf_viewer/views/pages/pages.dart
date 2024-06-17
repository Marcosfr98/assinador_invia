import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

import "../../controller/controller.dart";

class PdfViewerPage extends StatefulWidget {
  final String? pdfUrl;

  const PdfViewerPage({super.key, required this.pdfUrl});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizar documento"),
        actions: [
          IconButton(
            onPressed: () async {
              if (widget.pdfUrl != null && widget.pdfUrl!.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                await PdfViewerControllerCustom.download(widget.pdfUrl!);
                setState(() {
                  isLoading = false;
                });
              }
            },
            icon: isLoading
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                : FaIcon(
                    FontAwesomeIcons.download,
                  ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (widget.pdfUrl != null && widget.pdfUrl!.isNotEmpty) {
            return SfPdfViewer.network(widget.pdfUrl!);
          } else {
            return Center(
              child: Text("Documento não encontrado!"),
            );
          }
        },
      ),
    );
  }
}
