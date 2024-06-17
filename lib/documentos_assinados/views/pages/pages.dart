import "package:assinador_invia/documentos_assinados/models/models.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";

import "../../controllers/controllers.dart";

class DocumentosAssinados extends StatefulWidget {
  const DocumentosAssinados({super.key});

  @override
  State<DocumentosAssinados> createState() => _DocumentosAssinadosState();
}

class _DocumentosAssinadosState extends State<DocumentosAssinados> {
  late Future<List<MeusDocumentosAssinados>> _futureAssiandos;

  @override
  void initState() {
    _futureAssiandos = DocumentosAssinadosController.getDocumentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MeusDocumentosAssinados>>(
        future: _futureAssiandos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      snapshot.data![index].desnome ?? "",
                      style: GoogleFonts.nunito(fontSize: 16.sp),
                    ),
                    subtitle: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      snapshot.data![index].desdescricao ?? "",
                      style: GoogleFonts.nunito(fontSize: 14.sp),
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.file,
                      size: 20.sp,
                    ),
                  );
                },
              );
            }
          }
          return SizedBox();
        });
  }
}
