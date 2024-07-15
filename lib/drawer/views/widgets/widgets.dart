import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../pastas/views/pages/pages.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/assinador.png",
                    height: 100.h,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ListTile(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                      Get.to(
                        () => PastasPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.folder,
                    ),
                    title: Text(
                      "Documentos",
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: FaIcon(
                      FontAwesomeIcons.gear,
                    ),
                    title: Text(
                      "Configurações",
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: FaIcon(
                      FontAwesomeIcons.addressBook,
                    ),
                    title: Text(
                      "Contatos",
                    ),
                  )
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  "Precisa de ajuda?",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
