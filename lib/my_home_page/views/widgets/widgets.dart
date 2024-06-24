import "package:assinador_invia/my_home_page/controllers/controllers.dart";
import "package:assinador_invia/my_home_page/models/fluxos_aguardando.dart";
import "package:assinador_invia/my_home_page/models/fluxos_finalizados.dart";
import "package:assinador_invia/my_home_page/models/fluxos_pendentes.dart";
import "package:assinador_invia/my_home_page/services/api.dart";
import "package:assinador_invia/my_home_page/views/pages/pages.dart";
import "package:assinador_invia/pdf_viewer/views/pages/pages.dart";
import "package:assinador_invia/webview/views/pages/pages.dart";
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
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentoItemWidget extends StatefulWidget {
  const DocumentoItemWidget({super.key});

  @override
  State<DocumentoItemWidget> createState() => _DocumentoItemWidgetState();
}

class _DocumentoItemWidgetState extends State<DocumentoItemWidget> {
  final MyHomePageController _myHomePageController =
      MyHomePageController.instance;
  late Future _futureFluxos;
  late Future _futurePendentes;
  late Future _futureFinalizados;
  @override
  void initState() {
    _futureFluxos = MyHomePageApiServices().getFluxosAguardando();
    _futurePendentes = MyHomePageApiServices().getFluxosPendentes();
    _futureFinalizados = MyHomePageApiServices().getFluxosFinalizados();
    super.initState();
  }

  @override
  void dispose() {
    _myHomePageController.changeDataFilter("Todas");
    _myHomePageController.changeStatusFilter("Nenhum");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_myHomePageController.groupValueStatus == "Aguardando") {
      _myHomePageController.changeIcon(
        FontAwesomeIcons.fileContract,
      );
    } else if (_myHomePageController.groupValueStatus == "Pendentes") {
      _myHomePageController.changeIcon(
        FontAwesomeIcons.fileCircleQuestion,
      );
    } else {
      _myHomePageController.changeIcon(
        FontAwesomeIcons.fileCircleCheck,
      );
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _myHomePageController,
      builder: (context, child) {
        if (_myHomePageController.groupValueStatus == "Aguardando") {
          return FutureBuilder(
            future: _futureFluxos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<FluxoAguardandoModel> fluxoAguardandoModel =
                      snapshot.data!;
                  return Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 77.h * fluxoAguardandoModel.length,
                      child: ListView.builder(
                        itemCount: fluxoAguardandoModel.length,
                        itemBuilder: (context, index) {
                          if (_myHomePageController.groupValueData == "Todos") {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileContract,
                                      ),
                                      title: Text(
                                        fluxoAguardandoModel[index].desnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .desemail ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .descpf ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Get.to(
                                            () => WebViewCustomWidget(
                                                url: fluxoAguardandoModel[index]
                                                        .signLink ??
                                                    ""),
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimos 12 meses" &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 365),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileContract,
                                      ),
                                      title: Text(
                                        fluxoAguardandoModel[index].desnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .desemail ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .descpf ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Get.to(
                                            () => WebViewCustomWidget(
                                                url: fluxoAguardandoModel[index]
                                                        .signLink ??
                                                    ""),
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimos 6 meses" &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 180),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileContract,
                                      ),
                                      title: Text(
                                        fluxoAguardandoModel[index].desnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .desemail ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .descpf ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimos 30 dias" &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 30),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileContract,
                                      ),
                                      title: Text(
                                        fluxoAguardandoModel[index].desnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .desemail ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .descpf ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Semana passada" &&
                              DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(
                                      fluxoAguardandoModel[index].dtassinatura!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 7),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileContract,
                                      ),
                                      title: Text(
                                        fluxoAguardandoModel[index].desnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .desemail ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .descpf ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimas 24 horas" &&
                              DateTime.parse(
                                      fluxoAguardandoModel[index].dtassinatura!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(
                                      fluxoAguardandoModel[index].dtassinatura!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 1),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileContract,
                                      ),
                                      title: Text(
                                        fluxoAguardandoModel[index].desnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .desemail ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxoAguardandoModel[index]
                                                    .descpf ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
              }
              return SizedBox();
            },
          );
        } else if (_myHomePageController.groupValueStatus == "Pendentes") {
          _myHomePageController.changeIcon(
            FontAwesomeIcons.fileCircleQuestion,
          );
          return FutureBuilder(
            future: _futurePendentes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<FluxosPendentesModel> fluxosPendentesModel =
                      snapshot.data!;
                  return Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 77.h * fluxosPendentesModel.length,
                      child: AnimatedBuilder(
                        animation: _myHomePageController,
                        builder: (context, child) {
                          return ListView.builder(
                            itemCount: fluxosPendentesModel.length,
                            itemBuilder: (context, index) {
                              if (_myHomePageController.groupValueData ==
                                  "Todos") {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 2.r,
                                      child: SizedBox(
                                        height: 75.h,
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () {
                                            Get.to(
                                              () => DetalhesDocumento(),
                                            );
                                          },
                                          leading: FaIcon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                          ),
                                          title: Text(
                                            fluxosPendentesModel[index]
                                                    .desdocnome ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .desdescricao ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .descategoria ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PdfViewer(
                                                    url: fluxosPendentesModel[
                                                                index]
                                                            .desdocassinado ??
                                                        ""),
                                              );
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.eye,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimos 12 meses" &&
                                  DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 365),
                                    ),
                                  )) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 2.r,
                                      child: SizedBox(
                                        height: 75.h,
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () {
                                            Get.to(
                                              () => DetalhesDocumento(),
                                            );
                                          },
                                          leading: FaIcon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                          ),
                                          title: Text(
                                            fluxosPendentesModel[index]
                                                    .desdocnome ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .desdescricao ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .descategoria ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PdfViewer(
                                                    url: fluxosPendentesModel[
                                                                index]
                                                            .desdocassinado ??
                                                        ""),
                                              );
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.eye,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimos 6 meses" &&
                                  DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                      .isAfter(
                                    DateTime.now()
                                        .subtract(Duration(days: 180)),
                                  )) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 2.r,
                                      child: SizedBox(
                                        height: 75.h,
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () {
                                            Get.to(
                                              () => DetalhesDocumento(),
                                            );
                                          },
                                          leading: FaIcon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                          ),
                                          title: Text(
                                            fluxosPendentesModel[index]
                                                    .desdocnome ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .desdescricao ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .descategoria ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PdfViewer(
                                                    url: fluxosPendentesModel[
                                                                index]
                                                            .desdocassinado ??
                                                        ""),
                                              );
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.eye,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimos 30 dias" &&
                                  DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 30),
                                    ),
                                  )) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 2.r,
                                      child: SizedBox(
                                        height: 75.h,
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () {
                                            Get.to(
                                              () => DetalhesDocumento(),
                                            );
                                          },
                                          leading: FaIcon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                          ),
                                          title: Text(
                                            fluxosPendentesModel[index]
                                                    .desdocnome ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .desdescricao ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .descategoria ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PdfViewer(
                                                    url: fluxosPendentesModel[
                                                                index]
                                                            .desdocassinado ??
                                                        ""),
                                              );
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.eye,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Semana passada" &&
                                  DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosPendentesModel[index]
                                          .dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 7),
                                    ),
                                  )) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 2.r,
                                      child: SizedBox(
                                        height: 75.h,
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () {
                                            Get.to(
                                              () => DetalhesDocumento(),
                                            );
                                          },
                                          leading: FaIcon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                          ),
                                          title: Text(
                                            fluxosPendentesModel[index]
                                                    .desdocnome ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .desdescricao ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .descategoria ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PdfViewer(
                                                    url: fluxosPendentesModel[
                                                                index]
                                                            .desdocassinado ??
                                                        ""),
                                              );
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.eye,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimas 24 horas" &&
                                  DateTime.parse(fluxosPendentesModel[index]
                                          .dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosPendentesModel[index]
                                          .dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 1),
                                    ),
                                  )) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 2.r,
                                      child: SizedBox(
                                        height: 75.h,
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () {
                                            Get.to(
                                              () => DetalhesDocumento(),
                                            );
                                          },
                                          leading: FaIcon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                          ),
                                          title: Text(
                                            fluxosPendentesModel[index]
                                                    .desdocnome ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .desdescricao ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                fluxosPendentesModel[index]
                                                        .descategoria ??
                                                    "",
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PdfViewer(
                                                    url: fluxosPendentesModel[
                                                                index]
                                                            .desdocassinado ??
                                                        ""),
                                              );
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.eye,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                );
                              }
                              return SizedBox();
                            },
                          );
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
              }
              return SizedBox();
            },
          );
        } else if (_myHomePageController.groupValueStatus == "Finalizados") {
          _myHomePageController.changeIcon(
            FontAwesomeIcons.fileCircleCheck,
          );
          return FutureBuilder(
            future: _futureFinalizados,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<FluxosFinalizadosModel> fluxosFinalizadosModel =
                      snapshot.data!;
                  return Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 77.h * fluxosFinalizadosModel.length,
                      child: ListView.builder(
                        itemCount: fluxosFinalizadosModel.length,
                        itemBuilder: (context, index) {
                          if (_myHomePageController.groupValueData == "Todos") {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                      ),
                                      title: Text(
                                        fluxosFinalizadosModel[index]
                                                .desdocnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .desdescricao ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .descategoria ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Get.to(
                                            () => PdfViewer(
                                                url: fluxosFinalizadosModel[
                                                            index]
                                                        .desdocassinado ??
                                                    ""),
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimos 12 meses" &&
                              DateTime.parse(fluxosFinalizadosModel[index].dtcadastro!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(fluxosFinalizadosModel[index].dtcadastro!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 365),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                      ),
                                      title: Text(
                                        fluxosFinalizadosModel[index]
                                                .desdocnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .desdescricao ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .descategoria ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Get.to(
                                            () => PdfViewer(
                                                url: fluxosFinalizadosModel[
                                                            index]
                                                        .desdocassinado ??
                                                    ""),
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimos 6 meses" &&
                              DateTime.parse(fluxosFinalizadosModel[index].dtcadastro!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 180),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                      ),
                                      title: Text(
                                        fluxosFinalizadosModel[index]
                                                .desdocnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .desdescricao ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .descategoria ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Últimos 30 dias" &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 30),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                      ),
                                      title: Text(
                                        fluxosFinalizadosModel[index]
                                                .desdocnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .desdescricao ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .descategoria ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          } else if (_myHomePageController.groupValueData ==
                                  "Semana passada" &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 7),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                      ),
                                      title: Text(
                                        fluxosFinalizadosModel[index]
                                                .desdocnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .desdescricao ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .descategoria ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          }
                          if (_myHomePageController.groupValueData ==
                                  "Últimas 24 horas" &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isBefore(DateTime.now()) &&
                              DateTime.parse(
                                      fluxosFinalizadosModel[index].dtcadastro!)
                                  .isAfter(
                                DateTime.now().subtract(
                                  Duration(days: 1),
                                ),
                              )) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 2.r,
                                  child: SizedBox(
                                    height: 75.h,
                                    child: ListTile(
                                      isThreeLine: true,
                                      onTap: () {
                                        Get.to(
                                          () => DetalhesDocumento(),
                                        );
                                      },
                                      leading: FaIcon(
                                        FontAwesomeIcons.fileCircleCheck,
                                      ),
                                      title: Text(
                                        fluxosFinalizadosModel[index]
                                                .desdocnome ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .desdescricao ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            fluxosFinalizadosModel[index]
                                                    .descategoria ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.eye,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }
              }
              return SizedBox();
            },
          );
        }
        return SizedBox();
      },
    );
  }
}

class NoDocumentsWidget extends StatelessWidget {
  const NoDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.fileCircleXmark,
              size: 64,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              "Nenhum documento encontrado para a pesquisa selecionada!",
            ),
          ],
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

class DocumentosWidget extends StatefulWidget {
  const DocumentosWidget({
    super.key,
  });

  @override
  State<DocumentosWidget> createState() => _DocumentosWidgetState();
}

class _DocumentosWidgetState extends State<DocumentosWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FilterWidget(),
        DocumentoItemWidget(),
      ],
    );
  }
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final _myHomePageController = MyHomePageController.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(
              .15,
            ),
          ),
        ),
      ),
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _myHomePageController,
            builder: (context, child) {
              return Text(
                _myHomePageController.groupValueStatus.isEmpty
                    ? "Nenhum"
                    : _myHomePageController.groupValueStatus,
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          Text(
            " · ",
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          AnimatedBuilder(
            animation: _myHomePageController,
            builder: (context, child) {
              return Text(
                _myHomePageController.groupValueData.isEmpty
                    ? "Todas"
                    : _myHomePageController.groupValueData,
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
