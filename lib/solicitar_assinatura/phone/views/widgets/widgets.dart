import "package:assinador_invia/home_page/controllers/controllers.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";
import "package:muskey/muskey.dart";

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

class AssinanteWidgetPhone extends StatefulWidget {
  final int index;

  const AssinanteWidgetPhone({
    super.key,
    required this.index,
  });

  @override
  State<AssinanteWidgetPhone> createState() => _AssinanteWidgetPhoneState();
}

class _AssinanteWidgetPhoneState extends State<AssinanteWidgetPhone> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (!HomePageController.hasSigner[widget.index]) {
        return ListTile(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => Dialog(
                child: DialogSignersWidgetPhone(index: widget.index),
              ),
            );
            setState(() {});
          },
          title: Text(
            "Assinante ${widget.index}",
            style: GoogleFonts.nunito(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Clique no + para adicionar",
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "",
                style: GoogleFonts.nunito(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          trailing: FaIcon(
            FontAwesomeIcons.plus,
            size: 18.sp,
          ),
        );
      } else {
        return ListTile(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => Dialog(
                child: DialogSignersWidgetPhone(index: widget.index),
              ),
            );

            setState(() {});
          },
          title: Text(
            HomePageController.nomeController[widget.index].text.isNotEmpty
                ? HomePageController.nomeController[widget.index].text
                : "Assinante ${widget.index}",
            style: GoogleFonts.nunito(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                HomePageController.cpfController[widget.index].text.isNotEmpty
                    ? HomePageController.cpfController[widget.index].text
                    : "Clique no + para adicionar",
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                HomePageController.emailController[widget.index].text.isNotEmpty
                    ? HomePageController.emailController[widget.index].text
                    : "",
                style: GoogleFonts.nunito(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          trailing: FaIcon(FontAwesomeIcons.plus),
        );
      }
    });
  }
}

class DialogSignersWidgetPhone extends StatefulWidget {
  final int index;

  const DialogSignersWidgetPhone({super.key, required this.index});

  @override
  State<DialogSignersWidgetPhone> createState() =>
      _DialogSignersWidgetPhoneState();
}

class _DialogSignersWidgetPhoneState extends State<DialogSignersWidgetPhone> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StatefulBuilder(builder: (context, builder) {
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
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Assinante ${widget.index}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: HomePageController.nomeController[widget.index],
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Campo nome não pode ser vazio!";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Nome do assinante",
                      labelText: "Nome do assinante",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (value.length != 14) {
                          return "Campo CPF deve conter exatos 14 caracteres!";
                        } else {
                          return null;
                        }
                      } else {
                        return "Campo nome não pode ser vazio!";
                      }
                    },
                    maxLength: 14,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      MuskeyFormatter(
                        masks: ['###.###.###-##'],
                        decorators: [".", "-"],
                        overflow: OverflowBehavior.forbidden(),
                      ),
                    ],
                    controller: HomePageController.cpfController[widget.index],
                    decoration: InputDecoration(
                      hintText: "CPF do assinante",
                      labelText: "CPF do assinante",
                    ),
                  ),
                  TextFormField(
                    controller:
                        HomePageController.emailController[widget.index],
                    validator: (value) {
                      RegExp emailRegex = RegExp(
                          r'^[a-z0-9!#$%&*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$');
                      if (value != null && value.isNotEmpty) {
                        if (emailRegex.hasMatch(value)) {
                          return null;
                        } else {
                          return "E-mail inválido!";
                        }
                      } else {
                        return "Valor não pode ser vazio!";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "E-mail do assinante",
                      labelText: "E-mail do assinante",
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Telefone não pode ser vazio!";
                      }
                    },
                    inputFormatters: [
                      MuskeyFormatter(
                        masks: ['(##) #####-####'],
                        decorators: ["(", ")", "-", " "],
                        overflow: OverflowBehavior.forbidden(),
                      ),
                    ],
                    keyboardType: TextInputType.number,
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
          ),
        );
      }),
    );
  }
}
