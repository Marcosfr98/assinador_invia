import "dart:convert";

import "package:assinador_invia/my_home_page/controllers/controllers.dart";
import "package:assinador_invia/my_home_page/models/assinantes_fluxo_model.dart";
import "package:assinador_invia/my_home_page/models/fluxos_aguardando.dart";
import "package:assinador_invia/my_home_page/models/fluxos_finalizados.dart";
import "package:assinador_invia/my_home_page/models/fluxos_pendentes.dart";
import "package:assinador_invia/my_home_page/services/api.dart";
import "package:assinador_invia/my_home_page/services/db.dart";
import "package:assinador_invia/my_home_page/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:url_launcher/url_launcher.dart";

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  final _myHomePageApiServices = MyHomePageApiServices.instance;
  final _myHomePageController = MyHomePageController.instance;
  late Future _futureActionNedded;
  late Future _futureWaitingOthers;
  bool _didFilter = false;

  Future<List<FluxoAguardandoModel>> getNeededAction() async {
    List<FluxoAguardandoModel> _fluxoAguardandoModel =
        await _myHomePageApiServices.getFluxosAguardando();
    return _fluxoAguardandoModel;
  }

  Future<List<FluxosPendentesModel>> getWaitingOthers() async {
    List<FluxosPendentesModel> _fluxosPendentesModel =
        await _myHomePageApiServices.getFluxosPendentes();
    return _fluxosPendentesModel;
  }

  @override
  void initState() {
    _futureActionNedded = getNeededAction();
    _futureWaitingOthers = getWaitingOthers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                          animation: _myHomePageController,
                          builder: (context, child) {
                            return InkWell(
                              onTap: () {
                                _myHomePageController
                                    .changeStatusFilter("Aguardando");
                                _myHomePageController.changeDataFilter("Todos");
                                _myHomePageController.changeCurrentIndex(1);
                              },
                              child: Ink(
                                padding: EdgeInsets.symmetric(horizontal: 8.r),
                                decoration: BoxDecoration(
                                  color: Color(0xFFEFEFEF),
                                ),
                                height: 100.h,
                                width: (MediaQuery.of(context).size.width / 2) -
                                    36,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder(
                                        future: _futureActionNedded,
                                        initialData: _myHomePageController
                                            .aguardandoInitialData,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Builder(
                                              builder: (context) {
                                                if (snapshot.data != null) {
                                                  return Text(
                                                    snapshot.data!.toString(),
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 32.sp,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                    "- -",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 32.sp,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          } else if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.length.toString(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 32.sp,
                                                color: Colors.blueAccent,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "0",
                                            style: GoogleFonts.nunito(
                                              fontSize: 32.sp,
                                              color: Colors.blueAccent,
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      "Ação necessária",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      InkWell(
                        onTap: () {
                          _myHomePageController.changeStatusFilter("Pendentes");
                          _myHomePageController.changeDataFilter("Todos");
                          _myHomePageController.changeCurrentIndex(1);
                        },
                        child: Ink(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                          decoration: BoxDecoration(
                            color: Color(0xFFEFEFEF),
                          ),
                          height: 100.h,
                          width: (MediaQuery.of(context).size.width / 2) - 36,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                  future: _futureWaitingOthers,
                                  initialData:
                                      _myHomePageController.pendenteInitialData,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Builder(
                                        builder: (context) {
                                          if (snapshot.data != null) {
                                            return Text(
                                              snapshot.data!.toString(),
                                              style: GoogleFonts.nunito(
                                                fontSize: 32.sp,
                                                color: Colors.blueAccent,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              "- -",
                                              style: GoogleFonts.nunito(
                                                fontSize: 32.sp,
                                                color: Colors.blueAccent,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Text(
                                        snapshot.data!.length.toString(),
                                        style: GoogleFonts.nunito(
                                          fontSize: 32.sp,
                                          color: Colors.blueAccent,
                                        ),
                                      );
                                    }
                                    return Text(
                                      "0",
                                      style: GoogleFonts.nunito(
                                        fontSize: 32.sp,
                                        color: Colors.blueAccent,
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "Aguardando outros",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        _didFilter = !_didFilter;
                        _myHomePageController.changeFilterRecent(false);
                      });
                    },
                    leading: FaIcon(
                      _didFilter
                          ? FontAwesomeIcons.arrowUpWideShort
                          : FontAwesomeIcons.arrowDownWideShort,
                      size: 18.sp,
                    ),
                    title: Text(
                      "Documentos recentes",
                      style: GoogleFonts.nunito(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: RecentDocumentsWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DocumentosItemWidget extends StatefulWidget {
  final String? search;

  const DocumentosItemWidget({super.key, this.search});

  @override
  State<DocumentosItemWidget> createState() => _DocumentosItemWidgetState();
}

class _DocumentosItemWidgetState extends State<DocumentosItemWidget> {
  final MyHomePageController _myHomePageController =
      MyHomePageController.instance;
  late Future _futureFluxos;
  late Future _futurePendentes;
  late Future _futureFinalizados;

  Future<List<dynamic>> combinedFutures() {
    return Future.wait([
      _futureFluxos,
      _futurePendentes,
      _futureFinalizados,
    ]);
  }

  @override
  void initState() {
    _futureFluxos = MyHomePageApiServices().getFluxosAguardando();
    _futurePendentes = MyHomePageApiServices().getFluxosPendentes();
    _futureFinalizados = MyHomePageApiServices().getFluxosFinalizados();
    super.initState();
  }

  @override
  void dispose() {
    _myHomePageController.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _myHomePageController,
        builder: (context, child) {
          if (_myHomePageController.didType) {
            return FutureBuilder(
              future: combinedFutures(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  List<FluxoAguardandoModel> fluxoAguardandoModel =
                      snapshot.data![0];
                  List<FluxosPendentesModel> fluxoPendentesModel =
                      snapshot.data![1];
                  List<FluxosFinalizadosModel> fluxoFinalizadosModel =
                      snapshot.data![2];
                  final results1 = fluxoAguardandoModel
                      .where((item) => item.desnome!
                          .toLowerCase()
                          .contains(_myHomePageController.search.toLowerCase()))
                      .toList();
                  final results2 = fluxoPendentesModel
                      .where((item) => item.desdocnome!
                          .toLowerCase()
                          .contains(_myHomePageController.search.toLowerCase()))
                      .toList();
                  final results3 = fluxoFinalizadosModel
                      .where((item) => item.desdocnome!
                          .toLowerCase()
                          .contains(_myHomePageController.search.toLowerCase()))
                      .toList();
                  var _filteredResults = <dynamic>[
                    ...results1,
                    ...results2,
                    ...results3
                  ];
                  return ListView.builder(
                    itemCount: _filteredResults.length,
                    itemBuilder: (context, index) => Builder(
                      builder: (context) {
                        if (_filteredResults[index] is FluxoAguardandoModel) {
                          return CustomDocumentListTitle(
                            title: _filteredResults[index].desnome ?? "",
                            subtitle: _filteredResults[index].descpf ?? "",
                            date: _filteredResults[index].dtassinatura ?? "",
                            item: _filteredResults[index],
                          );
                        } else if (_filteredResults[index]
                            is FluxosPendentesModel) {
                          return CustomDocumentListTitle(
                            title: _filteredResults[index].desdocnome ?? "",
                            subtitle:
                                _filteredResults[index].desdescricao ?? "",
                            date: _filteredResults[index].dtcadastro ?? "",
                            item: _filteredResults[index],
                          );
                        } else if (_filteredResults[index]
                            is FluxosFinalizadosModel) {
                          return CustomDocumentListTitle(
                            title: _filteredResults[index].desdocnome ?? "",
                            subtitle:
                                _filteredResults[index].desdescricao ?? "",
                            date: _filteredResults[index].dtcadastro ?? "",
                            item: _filteredResults[index],
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            );
          } else {
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
                              if (_myHomePageController.groupValueData ==
                                  "Todos") {
                                return CustomDocumentListTitle(
                                  title:
                                      fluxoAguardandoModel[index].desnome ?? "",
                                  subtitle:
                                      fluxoAguardandoModel[index].descpf ?? "",
                                  date: fluxoAguardandoModel[index]
                                          .dtassinatura ??
                                      "",
                                  item: fluxoAguardandoModel[index],
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
                                return CustomDocumentListTitle(
                                  title:
                                      fluxoAguardandoModel[index].desnome ?? "",
                                  subtitle:
                                      fluxoAguardandoModel[index].descpf ?? "",
                                  date: fluxoAguardandoModel[index]
                                          .dtassinatura ??
                                      "",
                                  item: fluxoAguardandoModel[index],
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
                                return CustomDocumentListTitle(
                                  title:
                                      fluxoAguardandoModel[index].desnome ?? "",
                                  subtitle:
                                      fluxoAguardandoModel[index].descpf ?? "",
                                  date: fluxoAguardandoModel[index]
                                          .dtassinatura ??
                                      "",
                                  item: fluxoAguardandoModel[index],
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
                                return CustomDocumentListTitle(
                                  title:
                                      fluxoAguardandoModel[index].desnome ?? "",
                                  subtitle:
                                      fluxoAguardandoModel[index].descpf ?? "",
                                  date: fluxoAguardandoModel[index]
                                          .dtassinatura ??
                                      "",
                                  item: fluxoAguardandoModel[index],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Semana passada" &&
                                  DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxoAguardandoModel[index].dtassinatura!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 7),
                                    ),
                                  )) {
                                return CustomDocumentListTitle(
                                  title:
                                      fluxoAguardandoModel[index].desnome ?? "",
                                  subtitle:
                                      fluxoAguardandoModel[index].descpf ?? "",
                                  date: fluxoAguardandoModel[index]
                                          .dtassinatura ??
                                      "",
                                  item: fluxoAguardandoModel[index],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimas 24 horas" &&
                                  DateTime.parse(fluxoAguardandoModel[index]
                                          .dtassinatura!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxoAguardandoModel[index]
                                          .dtassinatura!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 1),
                                    ),
                                  )) {
                                return CustomDocumentListTitle(
                                  title:
                                      fluxoAguardandoModel[index].desnome ?? "",
                                  subtitle:
                                      fluxoAguardandoModel[index].descpf ?? "",
                                  date: fluxoAguardandoModel[index]
                                          .dtassinatura ??
                                      "",
                                  item: fluxoAguardandoModel[index],
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
                                    return CustomDocumentListTitle(
                                      title: fluxosPendentesModel[index]
                                              .desdocnome ??
                                          "",
                                      subtitle: fluxosPendentesModel[index]
                                              .desdescricao ??
                                          "",
                                      date: fluxosPendentesModel[index]
                                              .dtcadastro ??
                                          "",
                                      item: fluxosPendentesModel[index],
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
                                    return CustomDocumentListTitle(
                                      title: fluxosPendentesModel[index]
                                              .desdocnome ??
                                          "",
                                      subtitle: fluxosPendentesModel[index]
                                              .desdescricao ??
                                          "",
                                      date: fluxosPendentesModel[index]
                                              .dtcadastro ??
                                          "",
                                      item: fluxosPendentesModel[index],
                                    );
                                  } else if (_myHomePageController
                                              .groupValueData ==
                                          "Últimos 6 meses" &&
                                      DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                          .isAfter(
                                        DateTime.now()
                                            .subtract(Duration(days: 180)),
                                      )) {
                                    return CustomDocumentListTitle(
                                      title: fluxosPendentesModel[index]
                                              .desdocnome ??
                                          "",
                                      subtitle: fluxosPendentesModel[index]
                                              .desdescricao ??
                                          "",
                                      date: fluxosPendentesModel[index]
                                              .dtcadastro ??
                                          "",
                                      item: fluxosPendentesModel[index],
                                    );
                                  } else if (_myHomePageController
                                              .groupValueData ==
                                          "Últimos 30 dias" &&
                                      DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                          .isBefore(DateTime.now()) &&
                                      DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                          .isAfter(
                                        DateTime.now().subtract(
                                          Duration(days: 30),
                                        ),
                                      )) {
                                    return CustomDocumentListTitle(
                                      title: fluxosPendentesModel[index]
                                              .desdocnome ??
                                          "",
                                      subtitle: fluxosPendentesModel[index]
                                              .desdescricao ??
                                          "",
                                      date: fluxosPendentesModel[index]
                                              .dtcadastro ??
                                          "",
                                      item: fluxosPendentesModel[index],
                                    );
                                  } else if (_myHomePageController
                                              .groupValueData ==
                                          "Semana passada" &&
                                      DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                          .isBefore(DateTime.now()) &&
                                      DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                          .isAfter(
                                        DateTime.now().subtract(
                                          Duration(days: 7),
                                        ),
                                      )) {
                                    return CustomDocumentListTitle(
                                      title: fluxosPendentesModel[index]
                                              .desdocnome ??
                                          "",
                                      subtitle: fluxosPendentesModel[index]
                                              .desdescricao ??
                                          "",
                                      date: fluxosPendentesModel[index]
                                              .dtcadastro ??
                                          "",
                                      item: fluxosPendentesModel[index],
                                    );
                                  } else if (_myHomePageController
                                              .groupValueData ==
                                          "Últimas 24 horas" &&
                                      DateTime.parse(fluxosPendentesModel[index].dtcadastro!)
                                          .isBefore(DateTime.now()) &&
                                      DateTime.parse(
                                              fluxosPendentesModel[index].dtcadastro!)
                                          .isAfter(
                                        DateTime.now().subtract(
                                          Duration(days: 1),
                                        ),
                                      )) {
                                    return CustomDocumentListTitle(
                                      title: fluxosPendentesModel[index]
                                              .desdocnome ??
                                          "",
                                      subtitle: fluxosPendentesModel[index]
                                              .desdescricao ??
                                          "",
                                      date: fluxosPendentesModel[index]
                                              .dtcadastro ??
                                          "",
                                      item: fluxosPendentesModel[index],
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
            } else if (_myHomePageController.groupValueStatus ==
                "Finalizados") {
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
                              if (_myHomePageController.groupValueData ==
                                  "Todos") {
                                return CustomDocumentListTitle(
                                  title: fluxosFinalizadosModel[index]
                                          .desdocnome ??
                                      "",
                                  subtitle: fluxosFinalizadosModel[index]
                                          .desdescricao ??
                                      "",
                                  date: fluxosFinalizadosModel[index]
                                          .dtcadastro ??
                                      "",
                                  item: fluxosFinalizadosModel[index],
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
                                return CustomDocumentListTitle(
                                  title: fluxosFinalizadosModel[index]
                                          .desdocnome ??
                                      "",
                                  subtitle: fluxosFinalizadosModel[index]
                                          .desdescricao ??
                                      "",
                                  date: fluxosFinalizadosModel[index]
                                          .dtcadastro ??
                                      "",
                                  item: fluxosFinalizadosModel[index],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimos 6 meses" &&
                                  DateTime.parse(fluxosFinalizadosModel[index].dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosFinalizadosModel[index].dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 180),
                                    ),
                                  )) {
                                return CustomDocumentListTitle(
                                  title: fluxosFinalizadosModel[index]
                                          .desdocnome ??
                                      "",
                                  subtitle: fluxosFinalizadosModel[index]
                                          .desdescricao ??
                                      "",
                                  date: fluxosFinalizadosModel[index]
                                          .dtcadastro ??
                                      "",
                                  item: fluxosFinalizadosModel[index],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Últimos 30 dias" &&
                                  DateTime.parse(fluxosFinalizadosModel[index].dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosFinalizadosModel[index]
                                          .dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 30),
                                    ),
                                  )) {
                                return CustomDocumentListTitle(
                                  title: fluxosFinalizadosModel[index]
                                          .desdocnome ??
                                      "",
                                  subtitle: fluxosFinalizadosModel[index]
                                          .desdescricao ??
                                      "",
                                  date: fluxosFinalizadosModel[index]
                                          .dtcadastro ??
                                      "",
                                  item: fluxosFinalizadosModel[index],
                                );
                              } else if (_myHomePageController.groupValueData ==
                                      "Semana passada" &&
                                  DateTime.parse(fluxosFinalizadosModel[index]
                                          .dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosFinalizadosModel[index]
                                          .dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 7),
                                    ),
                                  )) {
                                return CustomDocumentListTitle(
                                  title: fluxosFinalizadosModel[index]
                                          .desdocnome ??
                                      "",
                                  subtitle: fluxosFinalizadosModel[index]
                                          .desdescricao ??
                                      "",
                                  date: fluxosFinalizadosModel[index]
                                          .dtcadastro ??
                                      "",
                                  item: fluxosFinalizadosModel[index],
                                );
                              }
                              if (_myHomePageController.groupValueData ==
                                      "Últimas 24 horas" &&
                                  DateTime.parse(fluxosFinalizadosModel[index]
                                          .dtcadastro!)
                                      .isBefore(DateTime.now()) &&
                                  DateTime.parse(fluxosFinalizadosModel[index]
                                          .dtcadastro!)
                                      .isAfter(
                                    DateTime.now().subtract(
                                      Duration(days: 1),
                                    ),
                                  )) {
                                return CustomDocumentListTitle(
                                  title: fluxosFinalizadosModel[index]
                                          .desdocnome ??
                                      "",
                                  subtitle: fluxosFinalizadosModel[index]
                                          .desdescricao ??
                                      "",
                                  date: fluxosFinalizadosModel[index]
                                          .dtcadastro ??
                                      "",
                                  item: fluxosFinalizadosModel[index],
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
          }
        });
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

class DestinatarioWidget extends StatefulWidget {
  final dynamic fluxo;

  const DestinatarioWidget({super.key, required this.fluxo});

  @override
  State<DestinatarioWidget> createState() => _DestinatarioWidgetState();
}

class _DestinatarioWidgetState extends State<DestinatarioWidget> {
  late Future _future;

  @override
  void initState() {
    _future = MyHomePageApiServices()
        .getAssinantes(idFluxo: widget.fluxo.idassinatura!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<AssinanteFluxoModel> assinantes = snapshot.data;
              return SizedBox(
                height: assinantes.length + 100,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: assinantes.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: (MediaQuery.of(context).size.width * .85) - 24,
                          child: ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blueAccent,
                              child: Center(
                                child: Text(
                                  assinantes[index].desnome![0],
                                  style: GoogleFonts.nunito(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(
                              assinantes[index].desnome ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assinantes[index].desemail ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Builder(builder: (context) {
                                  if (assinantes[index].assinado != null &&
                                      assinantes[index].assinado!.isNotEmpty &&
                                      assinantes[index].assinado == "1") {
                                    return Text(
                                      "Já assinou",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16.sp, color: Colors.green),
                                    );
                                  } else if (assinantes[index].assinado !=
                                          null &&
                                      assinantes[index].assinado!.isNotEmpty &&
                                      assinantes[index].assinado == "0") {
                                    return Text(
                                      "Assinatura necessária",
                                      style: GoogleFonts.nunito(
                                          fontSize: 16.sp, color: Colors.red),
                                    );
                                  } else {
                                    return Text("Sem informações");
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          }
          return SizedBox();
        });
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FilterWidget(),
        DocumentosItemWidget(),
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
  void dispose() {
    super.dispose();
  }

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

class SearchingDocumentsWidget extends StatefulWidget {
  const SearchingDocumentsWidget({super.key});

  @override
  State<SearchingDocumentsWidget> createState() =>
      _SearchingDocumentsWidgetState();
}

class _SearchingDocumentsWidgetState extends State<SearchingDocumentsWidget> {
  final _myHomePageController = MyHomePageController.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _myHomePageController,
      builder: (context, child) {
        if (_myHomePageController.didType) {
          return DocumentosItemWidget(search: _myHomePageController.search);
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 36,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Nenhum documento encontrado para a pesquisa!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class CustomDocumentListTitle extends StatefulWidget {
  final bool? isRecent;
  final String title;
  final String subtitle;
  final String? date;
  final dynamic item;

  const CustomDocumentListTitle(
      {super.key,
      required this.title,
      required this.subtitle,
      this.date,
      this.item,
      this.isRecent});

  @override
  State<CustomDocumentListTitle> createState() =>
      _CustomDocumentListTitleState();
}

class _CustomDocumentListTitleState extends State<CustomDocumentListTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.r,
          child: IntrinsicHeight(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              isThreeLine: true,
              onTap: () async {
                Get.to(
                  () => DetalhesDocumento(
                    item: widget.isRecent != null && widget.isRecent!
                        ? FluxoAguardandoModel.fromJson(widget.item)
                        : widget.item,
                  ),
                );
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.fileContract,
                  ),
                ],
              ),
              title: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.nunito(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.date ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
}

class ListaDeDocumentos extends StatefulWidget {
  final dynamic item;

  const ListaDeDocumentos({super.key, required this.item});

  @override
  State<ListaDeDocumentos> createState() => _ListaDeDocumentosState();
}

class _ListaDeDocumentosState extends State<ListaDeDocumentos> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item is FluxoAguardandoModel) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Remetente: ",
                              style: GoogleFonts.nunito(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: widget.item.desnome ?? "",
                              style: GoogleFonts.nunito(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Telefone: ",
                              style: GoogleFonts.nunito(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: widget.item.destelefone ?? "",
                              style: GoogleFonts.nunito(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "E-mail: ",
                              style: GoogleFonts.nunito(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: widget.item.desemail ?? "",
                              style: GoogleFonts.nunito(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Destinatários",
                    style: GoogleFonts.nunito(
                        fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
            DestinatarioWidget(
              fluxo: widget.item,
            ),
            Divider(
              height: 32,
              thickness: 1.r,
              color: Colors.black.withOpacity(.25),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Column(
                children: [
                  Text(
                    "Instruções para Assinar um Documento",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Siga os passos abaixo para assinar um documento de forma rápida e segura:",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "1. Verifique os assinantes: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Antes de iniciar o processo, certifique-se de que todos os assinantes necessários estão presentes.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "2. Veja o documento a ser assinado: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Leia o documento com atenção para garantir que você concorda com todos os termos.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "3. Clique em \"Assinar Documento\": ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "No aplicativo, localize e clique no botão \"Assinar Documento\".",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "4. Abertura de link externo: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Um link externo será aberto automaticamente.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "5. Clique no botão verde \"Assinar\": ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "No link externo, encontre e clique no botão verde com o texto \"Assinar\".",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "6. Insira o código e os dados solicitados: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Digite o código recebido e preencha os outros dados solicitados na página.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "7. Documento assinado: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Após a inserção correta do código e dos dados, seu documento estará assinado.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "O que acontece depois?",
                    style: GoogleFonts.montserrat(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Notificação aos outros assinantes: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Todos os outros assinantes receberão uma notificação informando que você assinou o documento.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Atualização de status do documento: ",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "O documento sairá do fluxo de \"Aguardando\" e seguirá para a próxima etapa.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            SafeArea(
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    String idHash = base64Encode(
                      utf8.encode(widget.item.idassinatura),
                    );
                    await launchUrl(Uri.parse(
                        "https://invianf.com.br/inviassinador/signatureDetails.php?code=$idHash"));
                  } catch (e, stack) {
                    print("$e\n$stack");
                  }
                },
                label: Text("Link de assinatura"),
                icon: FaIcon(FontAwesomeIcons.signature),
              ),
            )
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Remetente: ",
                        style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        widget.item.desdocnome ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.nunito(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Descrição: ",
                        style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        widget.item.desdescricao,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.nunito(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Enviado: ",
                        style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        widget.item.dtcadastro,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.nunito(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Destinatários",
                    style: GoogleFonts.nunito(
                        fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  DestinatarioWidget(
                    fluxo: widget.item,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Column(
                children: [
                  Text(
                    "Instruções para Enviar um Lembrete para os Usuários",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Passo 1: Verifique os Assinantes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Antes de enviar os lembretes, é necessário verificar quais usuários ainda não assinaram o documento. Siga as instruções abaixo:",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Passo 2: Enviar Lembretes para Usuários Pendentes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Para garantir que todos os usuários pendentes sejam notificados, você precisa enviar um lembrete por e-mail e mensagem no WhatsApp. Siga os passos abaixo:",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "1. Enviar lembrete: Clique no botão abaixo \“Enviar lembrete\”",
                    style: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Passo 3: Receber Lembretes Quando os Usuários Assinarem",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Você será notificado via e-mail e WhatsApp quando os assinantes pendentes assinarem o documento. Não é necessário nenhuma ação adicional de sua parte para essa etapa. As notificações serão enviadas automaticamente.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "1. Notificação por E-mail:",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              " Verifique sua caixa de entrada regularmente para notificações de assinatura. Você receberá um e-mail informando que o usuário pendente assinou o documento.",
                          style: GoogleFonts.montserrat(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "2. Notificação por WhatsApp:",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              " Certifique-se de que seu WhatsApp está ativo e acessível. Você receberá uma mensagem informando que o usuário pendente assinou o documento.",
                          style: GoogleFonts.montserrat(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
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
}

class RecentDocumentsWidget extends StatefulWidget {
  const RecentDocumentsWidget({super.key});

  @override
  State<RecentDocumentsWidget> createState() => _RecentDocumentsWidgetState();
}

class _RecentDocumentsWidgetState extends State<RecentDocumentsWidget> {
  final _myHomePageController = MyHomePageController.instance;
  final _firestoreService = FirestoreServices.instance;
  late SharedPreferences snapshot;
  List<FluxoAguardandoModel> recentes = [];

  @override
  void initState() {
    _firestoreService.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, sizes) => SizedBox(
        height: sizes.maxHeight,
        width: sizes.maxWidth,
        child: FutureBuilder(
          future: _firestoreService.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return AnimatedBuilder(
                animation: _myHomePageController,
                builder: (context, child) {
                  return SizedBox();
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
