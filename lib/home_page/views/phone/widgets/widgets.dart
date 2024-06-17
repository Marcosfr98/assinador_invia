import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../../documentos_assinados/views/pages/pages.dart";
import "../../../../fluxos/views/pages/pages.dart";
import "../../../../solicitar_assinatura/phone/views/pages/pages.dart";

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

class Home extends StatelessWidget {
  final int currentIndex;

  const Home({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      return SolicitarAssinatura();
    } else if (currentIndex == 1) {
      return FluxosLista();
    } else if (currentIndex == 2) {
      return DocumentosAssinados();
    }
    return const SizedBox();
  }
}
