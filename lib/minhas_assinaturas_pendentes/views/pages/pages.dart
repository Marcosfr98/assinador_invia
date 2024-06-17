import "package:assinador_invia/webview/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";

import "../../controllers/controllers.dart";
import "../../models/models.dart";

class MinhasAssinaturasPendentesLista extends StatefulWidget {
  const MinhasAssinaturasPendentesLista({super.key});

  @override
  State<MinhasAssinaturasPendentesLista> createState() =>
      _MinhasAssinaturasPendentesListaState();
}

class _MinhasAssinaturasPendentesListaState
    extends State<MinhasAssinaturasPendentesLista> {
  late Future<List<MinhasAssinaturasPendentesModel>> _future;

  @override
  void initState() {
    _future = MinhasAssinaturasPendentes().getFluxos();
    super.initState();
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
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                snapshot.data![index].desnome ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Text(
                snapshot.data![index].descpf ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: FaIcon(FontAwesomeIcons.signature),
              trailing: PopupMenuButton(
                key: Key("$index"),
                onSelected: (itemSelected) async {
                  if (itemSelected == "Assinar") {
                    try {
                      if (snapshot.data![index].signLink != null &&
                          snapshot.data![index].signLink!.isNotEmpty) {
                        Get.to(
                          () => CustomWebView(
                            title: 'Assinar',
                            url: snapshot.data![index].signLink!,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              "Documento não encontrado!",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    } catch (e, stack) {
                      print("$e\n$stack");
                    }
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: "Assinar",
                      child: Text("Assinar"),
                    )
                  ];
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
