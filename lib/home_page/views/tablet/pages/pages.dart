import "package:assinador_invia/notifications/views/pages/pages.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../../../assinatura_rapida/views/pages/pages.dart";
import "../../phone/widgets/widgets.dart";
import "../widgets/widgets.dart";

class MyHomePageTablet extends StatefulWidget {
  const MyHomePageTablet({super.key});

  @override
  State<MyHomePageTablet> createState() => _MyHomePageTabletState();
}

class _MyHomePageTabletState extends State<MyHomePageTablet> {
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
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${dias[DateTime.now().weekday - 1]}",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 12.sp,
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
                      radius: 16.sp,
                      backgroundColor: Colors.black,
                      child: FaIcon(
                        FontAwesomeIcons.bell,
                        size: 18.sp,
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
                if (constraints.maxWidth >= 600) {
                  return HomeTablet(
                    currentIndex: _currentNavigationBarIndex,
                  );
                } else {
                  return Home(
                    currentIndex: _currentNavigationBarIndex,
                  );
                }
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
