import "dart:convert";
import "dart:ui";

import "package:assinador_invia/my_home_page/controllers/controllers.dart";
import "package:assinador_invia/my_home_page/models/assinantes_fluxo_model.dart";
import "package:assinador_invia/my_home_page/models/fluxos_aguardando.dart";
import "package:assinador_invia/my_home_page/models/fluxos_finalizados.dart";
import "package:assinador_invia/my_home_page/models/fluxos_pendentes.dart";
import "package:assinador_invia/my_home_page/services/api.dart";
import "package:assinador_invia/my_home_page/services/file_downloader.dart";
import "package:assinador_invia/my_home_page/views/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_expandable_fab/flutter_expandable_fab.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";
import "package:share_plus/share_plus.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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
                              _myHomePageController.changeIsSeraching(true);
                            },
                            onFieldSubmitted: (value) {
                              _myHomePageController.changeSearch("");
                              _myHomePageController.changeIsSeraching(false);
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
                                  _myHomePageController.dismiss();
                                },
                                child: Text("Cancelar"),
                              )
                            : _myHomePageController.currentIndex == 0
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
                                        builder: (context) => StatefulBuilder(builder: (context, builder) {
                                          return DraggableScrollableSheet(
                                            expand: false,
                                            initialChildSize: 0.9,
                                            minChildSize: 0.5,
                                            maxChildSize: 1.0,
                                            builder: (context, controller) => Container(
                                              height: MediaQuery.of(context).size.height,
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Center(
                                                      child: Text(
                                                        "Filtros",
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 22.sp,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 12,
                                                    child: ListView(
                                                      padding: EdgeInsets.symmetric(horizontal: 24.r),
                                                      children: [
                                                        Text(
                                                          "Status",
                                                          style: GoogleFonts.nunito(
                                                            fontSize: 22.sp,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            RadioListTile.adaptive(
                                                              title: Text("Finalizados"),
                                                              groupValue: _myHomePageController.groupValueStatus,
                                                              value: "Finalizados",
                                                              onChanged: (selected) {
                                                                _myHomePageController.changeIcon(
                                                                  FontAwesomeIcons.fileCircleCheck,
                                                                );
                                                                builder(() => _myHomePageController.changeStatusFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Pendentes"),
                                                              groupValue: _myHomePageController.groupValueStatus,
                                                              value: "Pendentes",
                                                              onChanged: (selected) {
                                                                _myHomePageController.changeIcon(
                                                                  FontAwesomeIcons.fileCircleQuestion,
                                                                );
                                                                builder(() => _myHomePageController.changeStatusFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Aguardando"),
                                                              groupValue: _myHomePageController.groupValueStatus,
                                                              value: "Aguardando",
                                                              onChanged: (selected) {
                                                                _myHomePageController.changeIcon(
                                                                  FontAwesomeIcons.fileCircleExclamation,
                                                                );
                                                                builder(() => _myHomePageController.changeStatusFilter(selected!));
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "Data",
                                                          style: GoogleFonts.nunito(
                                                            fontSize: 22.sp,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            RadioListTile.adaptive(
                                                              title: Text("Todos"),
                                                              value: "Todos",
                                                              groupValue: _myHomePageController.groupValueData,
                                                              onChanged: (selected) {
                                                                builder(() => _myHomePageController.changeDataFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Últimos 12 meses"),
                                                              value: "Últimos 12 meses",
                                                              groupValue: _myHomePageController.groupValueData,
                                                              onChanged: (selected) {
                                                                builder(() => _myHomePageController.changeDataFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Últimos 6 meses"),
                                                              value: "Últimos 6 meses",
                                                              groupValue: _myHomePageController.groupValueData,
                                                              onChanged: (selected) {
                                                                builder(() => _myHomePageController.changeDataFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Últimos 30 dias"),
                                                              value: "Últimos 30 dias",
                                                              groupValue: _myHomePageController.groupValueData,
                                                              onChanged: (selected) {
                                                                builder(() => _myHomePageController.changeDataFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Semana passada"),
                                                              value: "Semana passada",
                                                              groupValue: _myHomePageController.groupValueData,
                                                              onChanged: (selected) {
                                                                builder(() => _myHomePageController.changeDataFilter(selected!));
                                                              },
                                                            ),
                                                            RadioListTile.adaptive(
                                                              title: Text("Últimas 24 horas"),
                                                              value: "Últimas 24 horas",
                                                              groupValue: _myHomePageController.groupValueData,
                                                              onChanged: (selected) {
                                                                builder(() => _myHomePageController.changeDataFilter(selected!));
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
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Divider(
                                                          height: 5,
                                                          thickness: 1,
                                                          color: Colors.black.withOpacity(.1),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            OutlinedButton(
                                                              onPressed: () {
                                                                _myHomePageController.changeDataFilter("");
                                                                _myHomePageController.changeStatusFilter("");
                                                                if (Navigator.of(context).canPop()) {
                                                                  Navigator.of(context).pop();
                                                                }
                                                              },
                                                              style: OutlinedButton.styleFrom(
                                                                foregroundColor: Colors.redAccent,
                                                                side: BorderSide(
                                                                  color: Colors.redAccent,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              child: Text("Redefinir"),
                                                            ),
                                                            SizedBox(
                                                              width: 24.r,
                                                            ),
                                                            OutlinedButton(
                                                              onPressed: () {
                                                                if (Navigator.of(context).canPop()) {
                                                                  Navigator.of(context).pop();
                                                                }
                                                              },
                                                              style: OutlinedButton.styleFrom(
                                                                foregroundColor: Colors.blueAccent,
                                                                side: BorderSide(
                                                                  color: Colors.blueAccent,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              child: Text("Aplicar"),
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
                        controller: TabController(length: 2, vsync: this, initialIndex: _myHomePageController.currentIndex),
                        onTap: (tappedIndex) {
                          setState(() {
                            if (tappedIndex == 0) {
                              _myHomePageController.changeIcon(FontAwesomeIcons.file);
                              _myHomePageController.changeDataFilter("Todas");
                              _myHomePageController.changeStatusFilter("Nenhum");
                            }
                            _myHomePageController.changeCurrentIndex(tappedIndex);
                          });
                        },
                        tabs: tabs,
                      ),
                    ),
              drawer: _myHomePageController.currentIndex == 0 ? Drawer() : null,
              body: Stack(
                children: [
                  _myHomePageController.isSearching ? SearchingDocumentsWidget() : _pages[_myHomePageController.currentIndex],
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
  final dynamic item;

  const DetalhesDocumento({super.key, required this.item});

  @override
  State<DetalhesDocumento> createState() => _DetalhesDocumentoState();
}

class _DetalhesDocumentoState extends State<DetalhesDocumento> {
  bool _isFirstPage = true;
  bool _isLastPage = false;
  final _myHomePageController = MyHomePageController.instance;
  final _myHomePageApiServices = MyHomePageApiServices.instance;
  bool _isSuccess = false;

  @override
  void initState() {
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
              return Text("Aguardando assinantes");
            } else if (widget.item is FluxosFinalizadosModel) {
              return Text("Documento assinado");
            } else if (widget.item is FluxosPendentesModel) {
              return Text("Aguardando assinatura");
            }
            return SizedBox();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (widget.item is FluxoAguardandoModel) {
              } else if (widget.item is FluxosFinalizadosModel || widget.item is FluxosPendentesModel) {
                if (widget.item.desdocassinado != null && widget.item.desdocassinado.isNotEmpty) {
                  await Share.share(widget.item.desdocassinado, subject: 'Dá uma olhada neste documento!');
                }
              }
            },
            icon: AnimatedBuilder(
              animation: _myHomePageController,
              builder: (context, child) {
                if (widget.item is FluxosFinalizadosModel || widget.item is FluxosPendentesModel) {
                  return _myHomePageController.isLoading ? CircularProgressIndicator() : FaIcon(FontAwesomeIcons.share);
                }
                return SizedBox();
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              if (widget.item is FluxoAguardandoModel) {
              } else if (widget.item is FluxosFinalizadosModel || widget.item is FluxosPendentesModel) {
                _myHomePageController.changeIsLoading(true);
                if (widget.item.desdocassinado != null && widget.item.desdocassinado.isNotEmpty) {
                  String? filPath = await FileDownloaderService.instance.downloadFile(widget.item.desdocassinado);
                  if (filPath != null) {
                    _myHomePageController.changeIsLoading(false);
                  }
                } else {
                  _myHomePageController.changeIsLoading(false);
                }
              }
            },
            icon: AnimatedBuilder(
              animation: _myHomePageController,
              builder: (context, child) {
                if (widget.item is FluxoAguardandoModel) {
                  return FaIcon(FontAwesomeIcons.signature);
                } else if (widget.item is FluxosFinalizadosModel || widget.item is FluxosPendentesModel) {
                  return _myHomePageController.isLoading ? CircularProgressIndicator() : FaIcon(FontAwesomeIcons.download);
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (widget.item is FluxoAguardandoModel) {
          return ListaDeDocumentos(
            item: widget.item,
          );
        } else if (widget.item is FluxosPendentesModel || widget.item is FluxosFinalizadosModel) {
          return ListaDeDocumentos(
            item: widget.item,
          );
        }
        return SizedBox();
      }),
      bottomNavigationBar: FutureBuilder(
        future: _myHomePageApiServices.getAssinantes(idFluxo: widget.item.idassinatura),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              height: 100,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<AssinanteFluxoModel> assinantes = snapshot.data!;
              var didSign = assinantes.where((assinante) => assinante.assinado == "0");
              if (didSign.length >= 1) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                          animation: _myHomePageController,
                          builder: (context, child) {
                            if (_myHomePageController.isLoading) {
                              return CircularProgressIndicator();
                            } else {
                              return AnimatedCrossFade(
                                firstChild: Chip(
                                  side: BorderSide.none,
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    "Enviado!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                secondChild: SizedBox(),
                                crossFadeState: _isSuccess ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                duration: Duration(
                                  seconds: 1,
                                ),
                              );
                            }
                          }),
                      AnimatedBuilder(
                        animation: _myHomePageController,
                        builder: (context, child) {
                          if (widget.item is FluxosPendentesModel) {
                            return ElevatedButton.icon(
                              icon: FaIcon(FontAwesomeIcons.share),
                              onPressed: () async {
                                _myHomePageController.changeIsLoading(true);
                                List<AssinanteFluxoModel> assinantesFluxoModel = await _myHomePageApiServices.getAssinantes(idFluxo: widget.item.idassinatura);

                                await _myHomePageApiServices.sendEmailToSigners(
                                  assinantes: assinantesFluxoModel,
                                  remetente: "Marcos Felipe Freitas de Freitas",
                                  linkAssinatura: "https://invianf.com.br/inviassinador/detalhesAssinatura.php?code=${base64Encode(utf8.encode(widget.item.idassinatura))}",
                                  nameDocumento: widget.item.desdocnome,
                                );
                                _myHomePageController.changeIsLoading(false);
                                setState(() {
                                  _isSuccess = true;
                                });
                                await Future.delayed(
                                  Duration(seconds: 10),
                                  () => setState(() {
                                    _isSuccess = false;
                                  }),
                                );
                              },
                              label: Text("Lembrar outros"),
                            );
                          } else if (widget.item is FluxosFinalizadosModel) {
                            return ElevatedButton.icon(
                              icon: FaIcon(FontAwesomeIcons.share),
                              onPressed: () async {
                                _myHomePageController.changeIsLoading(true);
                                await _myHomePageApiServices.sendEmailToSigners(
                                  assinantes: widget.item.assinantes,
                                  remetente: "Marcos Felipe Freitas de Freitas",
                                  linkAssinatura: widget.item.signLink,
                                  nameDocumento: widget.item.desnome,
                                );
                                _myHomePageController.changeIsLoading(false);
                              },
                              label: Text("Lembrar outros"),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.white,
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return SizedBox();
            }
          }
          return SizedBox();
        },
      ),
    );
  }
}
