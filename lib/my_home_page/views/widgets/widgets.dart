import "package:assinador_invia/my_home_page/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

class InicioWidget extends StatelessWidget {
  const InicioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    height: 100.h,
                    width: (MediaQuery.of(context).size.width / 2) - 36,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: GoogleFonts.nunito(
                            fontSize: 32.sp,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Ação necessária",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 14.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    height: 100.h,
                    width: (MediaQuery.of(context).size.width / 2) - 36,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: GoogleFonts.nunito(
                            fontSize: 32.sp,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Aguardando outros",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              fontSize: 14.sp, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Atividades recentes",
                    style: GoogleFonts.nunito(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: 87.h * 5,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => Column(
                        children: [
                          DocumentoItemWidget(index: index),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentoItemWidget extends StatelessWidget {
  final int index;

  const DocumentoItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.r,
      color: Colors.white,
      child: SizedBox(
        height: 75.h,
        child: ListTile(
          onTap: () {
            Get.to(
              () => DetalhesDocumento(),
            );
          },
          leading: FaIcon(
            FontAwesomeIcons.clock,
          ),
          title: Text(
            "Finalize com a Docusign: Digitalização de 2024-06-19 17:57:02",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.nunito(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Aguardando outros",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("Ontem"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DestinatarioWidget extends StatelessWidget {
  final int index;

  const DestinatarioWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.yellow,
        child: Center(
          child: Text("M"),
        ),
      ),
      title: Text("Marcos"),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("mffdfreitas@gmail.com"),
          Text("Assinatura necessária"),
        ],
      ),
    );
  }
}

class DocumentosWidget extends StatelessWidget {
  const DocumentosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Builder(builder: (context) {
        if (true) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.h,
              ),
              DocumentoItemWidget(index: 0),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.fileCircleXmark,
                size: 48.sp,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Nenhum documento encontrado para o filtro selecionado",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black54,
                  fixedSize: Size.fromHeight(50.h),
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                  ),
                ),
                child: Text(
                  "Redefinir",
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
