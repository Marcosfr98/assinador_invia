import "package:assinador_invia/assinatura_rapida/views/pages/pages.dart";
import "package:assinador_invia/home_page/views/phone/widgets/widgets.dart";
import "package:assinador_invia/notifications/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

import "../../tablet/widgets/widgets.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentNavigationBarIndex = 0;
  List<String> dias = [
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado",
    "Domingo",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: NetworkImage(
                        "https://wl-incrivel.cf.tsp.li/resize/728x/jpg/f6e/ef6/b5b68253409b796f61f6ecd1f1.jpg"),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MARCOS FELIPE FREITAS DE FREITAS",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${dias[DateTime.now().weekday - 1]}",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Get.to(
                        () => NotificationsPage(),
                      );
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: FaIcon(
                        FontAwesomeIcons.bell,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 768) {
                  return HomeTablet(
                    currentIndex: _currentNavigationBarIndex,
                  );
                } else if (constraints.maxWidth < 768) {
                  return Home(
                    currentIndex: _currentNavigationBarIndex,
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => AssinaturaRapida(),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _currentNavigationBarIndex >= 3 ? 0 : _currentNavigationBarIndex,
        onTap: (tappedIndex) {
          setState(() {
            _currentNavigationBarIndex = tappedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Solicitar",
            icon: FaIcon(
              FontAwesomeIcons.signature,
            ),
          ),
          BottomNavigationBarItem(
            label: "Fluxos",
            icon: FaIcon(
              FontAwesomeIcons.diagramProject,
            ),
          ),
          BottomNavigationBarItem(
            label: "Assinados",
            icon: FaIcon(
              FontAwesomeIcons.spinner,
            ),
          ),
        ],
      ),
    );
  }
}
