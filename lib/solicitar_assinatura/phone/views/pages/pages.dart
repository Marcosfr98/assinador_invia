import "package:assinador_invia/solicitar_assinatura/phone/views/widgets/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class SolicitarAssinatura extends StatefulWidget {
  const SolicitarAssinatura({super.key});

  @override
  State<SolicitarAssinatura> createState() => _SolicitarAssinaturaState();
}

class _SolicitarAssinaturaState extends State<SolicitarAssinatura> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nome do documento",
                labelText: "Nome",
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Descrição do documento",
                labelText: "Descrição",
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Etiqueta do documento",
                labelText: "Etiqueta",
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nome do documento",
                labelText: "Nome do documento",
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextButton.icon(
              icon: FaIcon(FontAwesomeIcons.calendar, size: 22.sp),
              onPressed: () {},
              label: Text(
                "Data limite",
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            AssinanteWidgetPhone(
              index: 1,
            ),
            AssinanteWidgetPhone(
              index: 2,
            ),
            AssinanteWidgetPhone(
              index: 3,
            ),
            AssinanteWidgetPhone(
              index: 4,
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Solicitar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
