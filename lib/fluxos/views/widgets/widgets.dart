import "package:assinador_invia/webview/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../pdf_viewer/views/pages/pages.dart";

class FluxoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String url;
  final int index;
  final String type;

  const FluxoItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.index,
      required this.url,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title ?? "",
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.nunito(fontSize: 16.sp),
        maxLines: 2,
      ),
      subtitle: Text(
        subtitle ?? "",
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.nunito(fontSize: 14.sp),
        maxLines: 1,
      ),
      leading: FaIcon(
        FontAwesomeIcons.fileContract,
        size: 20.sp,
      ),
      trailing: PopupMenuButton(
        iconSize: 18.sp,
        tooltip: "Ver documento",
        key: Key("$index"),
        onSelected: (itemSelected) async {
          if (itemSelected == "Baixar documento") {
            Get.to(
              () => PdfViewerPage(pdfUrl: url ?? ""),
            );
          } else if (itemSelected == "Assinar") {
            Get.to(
              () => CustomWebView(title: title, url: url),
            );
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: "Baixar documento",
              child: Text(
                "Ver documento",
                style: GoogleFonts.nunito(fontSize: 14.sp),
              ),
            ),
            PopupMenuItem(
              value: "Assinar",
              child: Text(
                "Assinar",
                style: GoogleFonts.nunito(fontSize: 14.sp),
              ),
              enabled: type == "Aguardando" ? true : false,
            ),
          ];
        },
      ),
    );
  }
}
