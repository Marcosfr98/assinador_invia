import "package:assinador_invia/home_page/controllers/controllers.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../../../home_page/views/tablet/widgets/widgets.dart";

class SolicitarAssinaturaTablet extends StatefulWidget {
  const SolicitarAssinaturaTablet({super.key});

  @override
  State<SolicitarAssinaturaTablet> createState() =>
      _SolicitarAssinaturaTabletState();
}

class _SolicitarAssinaturaTabletState extends State<SolicitarAssinaturaTablet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 50.r, vertical: 24.r),
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
        Container(
          padding: EdgeInsets.only(
            right: 24.r,
            left: 24.r,
          ),
          height: HomePageController.numberOfSigners * 187.h + 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: HomePageController.numberOfSigners,
                    itemBuilder: (context, index) {
                      return AssinanteWidgetTablet(
                        index: index,
                      );
                    }),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (HomePageController.numberOfSigners <= 4) {
                            HomePageController.numberOfSigners++;
                          }
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (HomePageController.numberOfSigners != 1) {
                            HomePageController.numberOfSigners--;
                          } else {
                            HomePageController.hasSigner = [
                              false,
                              false,
                              false,
                              false,
                              false
                            ];
                          }
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.trash,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
