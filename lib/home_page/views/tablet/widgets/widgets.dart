import "package:assinador_invia/home_page/controllers/controllers.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../../../documentos_assinados/views/pages/pages.dart";
import "../../../../../fluxos/views/pages/pages.dart";
import "../../../../solicitar_assinatura/tablet/views/pages/pages.dart";

class GridViewItens extends StatefulWidget {
  const GridViewItens({super.key});

  @override
  State<GridViewItens> createState() => _GridViewItensState();
}

class _GridViewItensState extends State<GridViewItens> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.r,
        crossAxisSpacing: 4.r,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF353535),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "0",
                    style: GoogleFonts.nunito(
                        fontSize: 32.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Text(
                    "Assinaturas rápidas",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text("Visualizar"),
                  ),
                ),
              ],
            ),
          );
        } else if (index == 1) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF353535),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "0",
                    style: GoogleFonts.nunito(
                        fontSize: 32.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Text(
                    "Fluxos finalizados",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text("Visualizar"),
                  ),
                ),
              ],
            ),
          );
        } else if (index == 2) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF353535),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "0",
                    style: GoogleFonts.nunito(
                        fontSize: 32.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Text(
                    "Minhas assinaturas pendentes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text("Visualizar"),
                  ),
                ),
              ],
            ),
          );
        } else if (index == 0) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF353535),
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF353535),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "0",
                    style: GoogleFonts.nunito(
                        fontSize: 32.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Text(
                    "Fluxos pendentes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text("Visualizar"),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class HomeTablet extends StatelessWidget {
  final int currentIndex;

  const HomeTablet({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      return SolicitarAssinaturaTablet();
    } else if (currentIndex == 1) {
      return FluxosLista();
    } else if (currentIndex == 2) {
      return DocumentosAssinados();
    }
    return const SizedBox();
  }
}

class AssinanteWidgetTablet extends StatefulWidget {
  final int index;

  const AssinanteWidgetTablet({
    super.key,
    required this.index,
  });

  @override
  State<AssinanteWidgetTablet> createState() => _AssinanteWidgetTabletState();
}

class _AssinanteWidgetTabletState extends State<AssinanteWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return DialogSignersWidget(
                index: widget.index,
              );
            },
          );
        },
        icon: FaIcon(
          FontAwesomeIcons.plus,
        ),
      ),
      title: Builder(
        builder: (context) {
          if (HomePageController.nomeController[widget.index].text.isNotEmpty) {
            return Text(HomePageController.nomeController[widget.index].text);
          } else {
            return Text("Assinante ${widget.index}");
          }
        },
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              if (HomePageController
                  .cpfController[widget.index].text.isNotEmpty) {
                return Text(
                    HomePageController.cpfController[widget.index].text);
              } else {
                return Text("Clique no + para adicionar");
              }
            },
          ),
          Builder(
            builder: (context) {
              if (HomePageController
                  .emailController[widget.index].text.isNotEmpty) {
                return Text(
                    HomePageController.emailController[widget.index].text);
              } else {
                return Text("");
              }
            },
          ),
        ],
      ),
    );
  }
}

class DialogSignersWidget extends StatefulWidget {
  final int index;

  const DialogSignersWidget({super.key, required this.index});

  @override
  State<DialogSignersWidget> createState() => _DialogSignersWidgetState();
}

class _DialogSignersWidgetState extends State<DialogSignersWidget> {
  @override
  void initState() {
    if (!HomePageController.hasSigner[widget.index]) {
      HomePageController.nomeController[widget.index].clear();
      HomePageController.cpfController[widget.index].clear();
      HomePageController.telefoneController[widget.index].clear();
      HomePageController.emailController[widget.index].clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StatefulBuilder(
        builder: (context, builder) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Assinante ${widget.index + 1}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: HomePageController.nomeController[widget.index],
                    decoration: InputDecoration(
                      hintText: "Nome do assinante",
                      labelText: "Nome do assinante",
                    ),
                  ),
                  TextFormField(
                    controller: HomePageController.cpfController[widget.index],
                    decoration: InputDecoration(
                      hintText: "CPF do assinante",
                      labelText: "CPF do assinante",
                    ),
                  ),
                  TextFormField(
                    controller:
                        HomePageController.emailController[widget.index],
                    decoration: InputDecoration(
                      hintText: "E-mail do assinante",
                      labelText: "E-mail do assinante",
                    ),
                  ),
                  TextFormField(
                    controller:
                        HomePageController.telefoneController[widget.index],
                    decoration: InputDecoration(
                      hintText: "Telefone do assinante",
                      labelText: "Telefone do assinante",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        HomePageController.hasSigner[widget.index] = true;
                      });
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                      setState(() {});
                    },
                    child: Text(
                      "Adicionar assinante",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
