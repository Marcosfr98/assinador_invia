import "dart:ui";

import "package:assinador_invia/my_home_page/controllers/controllers.dart";
import "package:assinador_invia/my_home_page/views/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_expandable_fab/flutter_expandable_fab.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late List<Widget> _pages;
  MyHomePageController _myHomePageController = MyHomePageController.instance;

  @override
  void didChangeDependencies() {
    _pages = [
      InicioWidget(),
      DocumentosWidget(),
    ];
    super.didChangeDependencies();
  }

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
                        _currentIndex == 0
                            ? IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  backgroundColor: Color(0xFFEFEFEF),
                                  child: FaIcon(
                                    FontAwesomeIcons.user,
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
                                                MainAxisAlignment.spaceBetween,
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.r),
                                                  children: [
                                                    Text(
                                                      "Status",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        RadioListTile.adaptive(
                                                          title: Text(
                                                              "Todos os documentos"),
                                                          groupValue:
                                                              _myHomePageController
                                                                  .groupValueStatus,
                                                          value:
                                                              "Todos os documentos",
                                                          onChanged:
                                                              (selected) {
                                                            builder(() =>
                                                                _myHomePageController
                                                                    .changeStatusFilter(
                                                                        selected!));
                                                          },
                                                        ),
                                                        RadioListTile.adaptive(
                                                          title: Text(
                                                              "Finalizados"),
                                                          groupValue:
                                                              _myHomePageController
                                                                  .groupValueStatus,
                                                          value: "Finalizados",
                                                          onChanged:
                                                              (selected) {
                                                            builder(() =>
                                                                _myHomePageController
                                                                    .changeStatusFilter(
                                                                        selected!));
                                                          },
                                                        ),
                                                        RadioListTile.adaptive(
                                                          title:
                                                              Text("Pendentes"),
                                                          groupValue:
                                                              _myHomePageController
                                                                  .groupValueStatus,
                                                          value: "Pendentes",
                                                          onChanged:
                                                              (selected) {
                                                            builder(() =>
                                                                _myHomePageController
                                                                    .changeStatusFilter(
                                                                        selected!));
                                                          },
                                                        ),
                                                        RadioListTile.adaptive(
                                                          title: Text(
                                                              "Aguardando"),
                                                          groupValue:
                                                              _myHomePageController
                                                                  .groupValueStatus,
                                                          value: "Aguardando",
                                                          onChanged:
                                                              (selected) {
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
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        RadioListTile.adaptive(
                                                          title: Text("Todos"),
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
                                                        RadioListTile.adaptive(
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
                                                        RadioListTile.adaptive(
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
                                                        RadioListTile.adaptive(
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
                                                        RadioListTile.adaptive(
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
                                                        RadioListTile.adaptive(
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
                                                      CrossAxisAlignment.center,
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
                                                          style: OutlinedButton
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
                                                          child:
                                                              Text("Redefinir"),
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
                                                          style: OutlinedButton
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
                        onTap: (tappedIndex) {
                          setState(() {
                            _currentIndex = tappedIndex;
                          });
                        },
                        tabs: [
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
                              FaIcon(
                                FontAwesomeIcons.file,
                              ),
                              Text("Documentos")
                            ],
                          ),
                        ],
                      ),
                    ),
              drawer: _currentIndex == 0 ? Drawer() : null,
              body: AnimatedBuilder(
                  animation: _myHomePageController,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        _pages[_currentIndex],
                        !_myHomePageController.isFabOpened
                            ? SizedBox()
                            : BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.75),
                                  ),
                                ),
                              ),
                      ],
                    );
                  }),
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: ExpandableFab(
                openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const FaIcon(FontAwesomeIcons.plus),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  shape: const CircleBorder(),
                ),
                onOpen: () {
                  setState(() {
                    _myHomePageController.openCloseFab(true);
                  });
                },
                onClose: () {
                  setState(() {
                    _myHomePageController.openCloseFab(false);
                  });
                },
                children: [
                  FloatingActionButton.large(
                    heroTag: null,
                    child: FaIcon(
                      FontAwesomeIcons.signature,
                      size: 24.sp,
                    ),
                    onPressed: () {},
                  ),
                  FloatingActionButton.large(
                    heroTag: null,
                    child: Icon(
                      Icons.people,
                      size: 24.sp,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class DetalhesDocumento extends StatefulWidget {
  const DetalhesDocumento({super.key});

  @override
  State<DetalhesDocumento> createState() => _DetalhesDocumentoState();
}

class _DetalhesDocumentoState extends State<DetalhesDocumento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.eye,
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.r),
        children: [
          SizedBox(
            height: 24.h,
          ),
          Text(
            "Finalize com a Docusign: Digitalização de 2024-06-19 17:57:02",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.nunito(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Rementente: ",
                    style: GoogleFonts.nunito(fontSize: 16.sp),
                  ),
                  Text(
                    "Marcos Freitas",
                    style: GoogleFonts.nunito(fontSize: 16.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "E-mail: ",
                    style: GoogleFonts.nunito(fontSize: 16.sp),
                  ),
                  Text(
                    "desenvolvimento1@invia.com.br",
                    style: GoogleFonts.nunito(fontSize: 16.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Enviado: ",
                    style: GoogleFonts.nunito(fontSize: 16.sp),
                  ),
                  Text(
                    "19 de jun. de 2024 5:59 PM",
                    style: GoogleFonts.nunito(fontSize: 16.sp),
                  ),
                ],
              )
            ],
          ),
          Divider(
            height: 24.h,
            thickness: 1,
            color: Colors.black.withOpacity(.2),
          ),
          Text(
            "Destinatários",
            style: GoogleFonts.nunito(
                fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 100.h * 2,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => DestinatarioWidget(
                index: index,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.r),
        height: 75.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.clock),
            Text(
              "Aguardando outros",
              style: GoogleFonts.nunito(
                fontSize: 16.sp,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Lembrar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
