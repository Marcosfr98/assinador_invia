import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<String> mes = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];
  int listLength = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: Text(
                    "Excluir notificações",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  content: Text(
                    "Tem certeza que deseja excluir as notificações?",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          listLength = 0;
                        });
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: TextButton.styleFrom(
                        textStyle: GoogleFonts.nunito(
                          fontSize: 16.sp,
                        ),
                      ),
                      child: Text("Sim"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: TextButton.styleFrom(
                        textStyle: GoogleFonts.nunito(
                          fontSize: 16.sp,
                        ),
                      ),
                      child: Text("Cancelar"),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: ListView(
        children: List.generate(
          listLength,
          (index) => ListTile(
            leading: FaIcon(
              FontAwesomeIcons.bell,
              size: 20.sp,
            ),
            title: Text(
              "Solicitação de assinatura",
              style: TextStyle(fontSize: 16.sp),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Corpo $index",
                  style: TextStyle(fontSize: 14.sp),
                ),
                Text(
                  "${DateTime.now().day + index} de ${mes[DateTime.now().month - 1]} de ${DateTime.now().year}",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
