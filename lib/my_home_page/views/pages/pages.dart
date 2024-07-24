import "dart:ui";

import "package:assinador_invia/drawer/views/widgets/widgets.dart";
import "package:assinador_invia/my_home_page/controllers/controllers.dart";
import "package:assinador_invia/my_home_page/models/fluxos_aguardando.dart";
import "package:assinador_invia/my_home_page/models/fluxos_finalizados.dart";
import "package:assinador_invia/my_home_page/models/fluxos_pendentes.dart";
import "package:assinador_invia/my_home_page/models/type_variable.dart";
import "package:assinador_invia/my_home_page/services/api.dart";
import "package:assinador_invia/my_home_page/services/local_db.dart";
import "package:assinador_invia/my_home_page/views/widgets/widgets.dart";
import "package:assinador_invia/my_login_page/views/pages/pages.dart";
import "package:assinador_invia/pdf_viewer/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

import "../../services/db.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late List<Widget> _pages;

  MyHomePageController _myHomePageController = MyHomePageController.instance;
  LocalPersistence _localPersistance = LocalPersistence.instance;

  @override
  void didChangeDependencies() {
    _pages = [
      InicioWidget(),
      DocumentosWidget(),
    ];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _myHomePageController.dismiss();
    super.dispose();
  }

  late List<Widget> tabs = [
    Column(
      children: [
        FaIcon(
          FontAwesomeIcons.house,
        ),
        Text("Início")
      ],
    ),
    Column(
      children: [
        AnimatedBuilder(
          animation: _myHomePageController,
          builder: (context, child) {
            return FaIcon(
              _myHomePageController.icon,
            );
          },
        ),
        Text("Documentos")
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AnimatedBuilder(
        animation: _myHomePageController,
        builder: (context, child) {
          return Scaffold(
            appBar: _myHomePageController.isFabOpened
                ? null
                : AppBar(
                    title: SizedBox(
                      height: 40.h,
                      width: double.infinity,
                      child: Theme(
                        data: ThemeData(
                          inputDecorationTheme: InputDecorationTheme(
                            fillColor: Color(0xFFEFEFEF),
                            filled: true,
                            suffixIconColor: Colors.black45,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                            ),
                          ),
                        ),
                        child: TextFormField(
                          onTap: () {
                            _myHomePageController.changeIsSearching(true);
                          },
                          onFieldSubmitted: (value) {
                            _myHomePageController.changeSearch("");
                            _myHomePageController.changeIsSearching(false);
                            _myHomePageController.changeDidType(false);
                            _myHomePageController.searchingController.clear();
                          },
                          onChanged: (value) {
                            _myHomePageController.changeSearch(value);
                            if (value.length >= 2) {
                              _myHomePageController.changeDidType(true);
                            } else {
                              _myHomePageController.changeDidType(false);
                            }
                          },
                          controller: _myHomePageController.searchingController,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(14.r),
                              child: FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                                size: 14.sp,
                              ),
                            ),
                            hintText: "Pesquisar por documentos",
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      _myHomePageController.isSearching
                          ? TextButton(
                              onPressed: () {
                                _myHomePageController.changeSearch("");
                                _myHomePageController.changeIsSearching(false);
                                _myHomePageController.changeDidType(false);
                                _myHomePageController.searchingController
                                    .clear();
                              },
                              child: Text("Cancelar"),
                            )
                          : _myHomePageController.currentIndex == 0
                              ? IconButton(
                                  onPressed: () async {
                                    await _localPersistance.setData(
                                      key: "isLoggedIn",
                                      value: false,
                                      type: TypeVariable.bool,
                                    );
                                    Get.offAll(() => MyLoginPage(),
                                        transition: Transition.fadeIn);
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Color(0xFFEFEFEF),
                                    child: FaIcon(
                                      FontAwesomeIcons.arrowRightFromBracket,
                                      color: Colors.black45,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => StatefulBuilder(
                                          builder: (context, builder) {
                                        return DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.9,
                                          minChildSize: 0.5,
                                          maxChildSize: 1.0,
                                          builder: (context, controller) =>
                                              Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: Text(
                                                      "Filtros",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 12,
                                                  child: ListView(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 24.r),
                                                    children: [
                                                      Text(
                                                        "Status",
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 22.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Finalizados"),
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueStatus,
                                                            value:
                                                                "Finalizados",
                                                            onChanged:
                                                                (selected) {
                                                              _myHomePageController
                                                                  .changeIcon(
                                                                FontAwesomeIcons
                                                                    .fileCircleCheck,
                                                              );
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeStatusFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Pendentes"),
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueStatus,
                                                            value: "Pendentes",
                                                            onChanged:
                                                                (selected) {
                                                              _myHomePageController
                                                                  .changeIcon(
                                                                FontAwesomeIcons
                                                                    .fileCircleQuestion,
                                                              );
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeStatusFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Aguardando"),
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueStatus,
                                                            value: "Aguardando",
                                                            onChanged:
                                                                (selected) {
                                                              _myHomePageController
                                                                  .changeIcon(
                                                                FontAwesomeIcons
                                                                    .fileCircleExclamation,
                                                              );
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeStatusFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "Data",
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 22.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          RadioListTile
                                                              .adaptive(
                                                            title:
                                                                Text("Todos"),
                                                            value: "Todos",
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueData,
                                                            onChanged:
                                                                (selected) {
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeDataFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Últimos 12 meses"),
                                                            value:
                                                                "Últimos 12 meses",
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueData,
                                                            onChanged:
                                                                (selected) {
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeDataFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Últimos 6 meses"),
                                                            value:
                                                                "Últimos 6 meses",
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueData,
                                                            onChanged:
                                                                (selected) {
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeDataFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Últimos 30 dias"),
                                                            value:
                                                                "Últimos 30 dias",
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueData,
                                                            onChanged:
                                                                (selected) {
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeDataFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Semana passada"),
                                                            value:
                                                                "Semana passada",
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueData,
                                                            onChanged:
                                                                (selected) {
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeDataFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                          RadioListTile
                                                              .adaptive(
                                                            title: Text(
                                                                "Últimas 24 horas"),
                                                            value:
                                                                "Últimas 24 horas",
                                                            groupValue:
                                                                _myHomePageController
                                                                    .groupValueData,
                                                            onChanged:
                                                                (selected) {
                                                              builder(() =>
                                                                  _myHomePageController
                                                                      .changeDataFilter(
                                                                          selected!));
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Divider(
                                                        height: 5,
                                                        thickness: 1,
                                                        color: Colors.black
                                                            .withOpacity(.1),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          OutlinedButton(
                                                            onPressed: () {
                                                              _myHomePageController
                                                                  .changeDataFilter(
                                                                      "");
                                                              _myHomePageController
                                                                  .changeStatusFilter(
                                                                      "");
                                                              if (Navigator.of(
                                                                      context)
                                                                  .canPop()) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  Colors
                                                                      .redAccent,
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .redAccent,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Text(
                                                                "Redefinir"),
                                                          ),
                                                          SizedBox(
                                                            width: 24.r,
                                                          ),
                                                          OutlinedButton(
                                                            onPressed: () {
                                                              if (Navigator.of(
                                                                      context)
                                                                  .canPop()) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              foregroundColor:
                                                                  Colors
                                                                      .blueAccent,
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .blueAccent,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child:
                                                                Text("Aplicar"),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.filter,
                                  ),
                                ),
                    ],
                    bottom: TabBar(
                      controller: TabController(
                          length: 2,
                          vsync: this,
                          initialIndex: _myHomePageController.currentIndex),
                      onTap: (tappedIndex) {
                        setState(
                          () {
                            if (tappedIndex == 0) {
                              _myHomePageController
                                  .changeIcon(FontAwesomeIcons.file);
                              _myHomePageController.changeDataFilter("Todas");
                              _myHomePageController
                                  .changeStatusFilter("Nenhum");
                            }
                            _myHomePageController
                                .changeCurrentIndex(tappedIndex);
                          },
                        );
                      },
                      tabs: tabs,
                    ),
                  ),
            drawer:
                _myHomePageController.currentIndex == 0 ? DrawerWidget() : null,
            body: Stack(
              children: [
                _myHomePageController.isSearching
                    ? SearchingDocumentsWidget()
                    : _pages[_myHomePageController.currentIndex],
                !_myHomePageController.isFabOpened
                    ? SizedBox()
                    : BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.75),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetalhesDocumento extends StatefulWidget {
  final dynamic item;

  const DetalhesDocumento({super.key, required this.item});

  @override
  State<DetalhesDocumento> createState() => _DetalhesDocumentoState();
}

class _DetalhesDocumentoState extends State<DetalhesDocumento> {
  final _myHomePageApiServices = MyHomePageApiServices.instance;
  final _db = FirestoreServices.instance;

  @override
  void initState() {
    FirestoreServices.instance.setData(widget.item);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            if (widget.item is FluxoAguardandoModel) {
              return Text("Aguardando assinatura");
            } else if (widget.item is FluxosFinalizadosModel) {
              return Text("Documento assinado");
            } else if (widget.item is FluxosPendentesModel) {
              return Text("Aguardando assinantes");
            }
            return SizedBox();
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              if (widget.item is FluxosPendentesModel ||
                  widget.item is FluxosFinalizadosModel) {
                return IconButton(
                  onPressed: () async {
                    Get.to(
                      () => PdfViewer(
                        url: widget.item.desdocassinado,
                      ),
                      transition: Transition.upToDown,
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.eye,
                  ),
                );
              } else if (widget.item is FluxoAguardandoModel) {
                return IconButton(
                  onPressed: () async {
                    Get.to(
                      () => PdfViewer(
                        url: widget.item.desdocassinado,
                      ),
                      transition: Transition.upToDown,
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.eye,
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (widget.item is FluxoAguardandoModel) {
            return ListaDeDocumentos(
              item: widget.item,
            );
          } else if (widget.item is FluxosPendentesModel ||
              widget.item is FluxosFinalizadosModel) {
            return ListaDeDocumentos(
              item: widget.item,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
