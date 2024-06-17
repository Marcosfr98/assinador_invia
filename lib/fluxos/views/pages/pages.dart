import "package:assinador_invia/fluxos/views/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../controllers/controllers.dart";
import "../../models/models.dart";

class FluxosLista extends StatefulWidget {
  const FluxosLista({super.key});

  @override
  State<FluxosLista> createState() => _FluxosListaState();
}

class _FluxosListaState extends State<FluxosLista> {
  late Future<List<FluxosPendentesModel>> _futurePendentes;
  late Future<List<FluxoFinalizadoModel>> _futureFinalizados;
  late Future<List<FluxoAguardandoModel>> _futureAguardando;
  int currentIndex = 0;
  Set<String> selected = {"Pendentes"};
  late List<Widget> _pages = [
    FutureBuilder(
      future: _futurePendentes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.purple
                ],
                stops: [
                  0.0,
                  0.1,
                  0.9,
                  1.0
                ], // 10% purple, 80% transparent, 10% purple
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => FluxoItem(
                      title: snapshot.data![index].desdocnome!,
                      subtitle: snapshot.data![index].desdescricao!,
                      index: index,
                      url: snapshot.data![index].desdocassinado!,
                      type: 'Pendentes',
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    ),
    FutureBuilder(
      future: _futureAguardando,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.purple
                ],
                stops: [
                  0.0,
                  0.1,
                  0.9,
                  1.0
                ], // 10% purple, 80% transparent, 10% purple
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => FluxoItem(
                      title: snapshot.data![index].desnome!,
                      subtitle: snapshot.data![index].descpf!,
                      index: index,
                      url: snapshot.data![index].signLink!,
                      type: 'Aguardando',
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    ),
    FutureBuilder(
      future: _futureFinalizados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.purple
                ],
                stops: [
                  0.0,
                  0.1,
                  0.9,
                  1.0
                ], // 10% purple, 80% transparent, 10% purple
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => FluxoItem(
                      title: snapshot.data![index].desdocnome!,
                      subtitle: snapshot.data![index].desdescricao!,
                      index: index,
                      url: snapshot.data![index].desdocassinado!,
                      type: 'Finalizados',
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    ),
  ];

  @override
  void initState() {
    _futurePendentes = FluxosPendentesControllers().getFluxosPendentes();
    _futureFinalizados = FluxosPendentesControllers().getFluxosFinalizados();
    _futureAguardando = FluxosPendentesControllers().getFluxosAguardando();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentIndex > 0 && currentIndex <= 2
                  ? FaIcon(FontAwesomeIcons.angleLeft)
                  : SizedBox(),
              Text(
                selected.toList()[0],
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentIndex != 2
                  ? FaIcon(FontAwesomeIcons.angleRight)
                  : SizedBox(),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: PageView(
            controller: PageController(
              viewportFraction: .85,
            ),
            padEnds: false,
            onPageChanged: (index) {
              if (index == 0) {
                setState(() {
                  selected = {"Pendentes"};
                  currentIndex = index;
                });
              } else if (index == 1) {
                setState(() {
                  selected = {"Aguardando"};
                  currentIndex = index;
                });
              } else {
                if (index == 2) {
                  setState(() {
                    selected = {"Finalizados"};
                    currentIndex = index;
                  });
                }
              }
            },
            children: _pages,
          ),
        ),
      ],
    );
  }
}
