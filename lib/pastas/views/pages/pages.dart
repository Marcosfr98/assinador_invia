import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PastasPage extends StatefulWidget {
  const PastasPage({super.key});

  @override
  State<PastasPage> createState() => _PastasPageState();
}

class _PastasPageState extends State<PastasPage> {
  String _groupValue = "date_created";
  bool _sameFolder = false;
  bool _isVisible = false;
  FocusNode _focusNode = FocusNode();
  String _periodo = "Selecione o período";
  int _currentIndex = 0;
  List<String> _folderNames = [
    "Administrativo",
    "Financeiro",
    "Comercial",
    "Atendimento",
  ];

  @override
  Widget build(BuildContext context) {
    late List<Widget> _pages = [
      Center(
        child: Text("Documentos"),
      ),
      Container(
        padding: EdgeInsets.only(
          top: 70.h,
          left: 24.r,
          right: 24.r,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${_folderNames.length} pastas",
                  style: GoogleFonts.montserrat(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: "Ordem alfabética crescente",
                      child: Text(
                        "Ordem alfabética crescente",
                      ),
                    ),
                    PopupMenuItem(
                      value: "Ordem alfabética decrescente",
                      child: Text(
                        "Ordem alfabética decrescente",
                      ),
                    ),
                    PopupMenuItem(
                      value: "Pasta mais antiga",
                      child: Text(
                        "Pasta mais antiga",
                      ),
                    ),
                    PopupMenuItem(
                      value: "Pasta mais recente",
                      child: Text(
                        "Pasta mais recente",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ...List.generate(
              _folderNames.length,
              (index) => ListTile(
                onTap: () {
                  Get.to(
                    () => Pasta(
                      nomeDaPasta: _folderNames[index],
                    ),
                  );
                },
                leading: FaIcon(FontAwesomeIcons.folder),
                title: Text("${_folderNames[index]}"),
              ),
            )
          ],
        ),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Pastas e documentos",
        ),
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          return Container(
            height: size.maxHeight,
            width: size.maxWidth,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: size.maxHeight,
                    width: size.maxWidth,
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: _currentIndex == 0 ? _pages[0] : _pages[1],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.r),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: _focusNode,
                        onTap: () {
                          setState(() {
                            _isVisible = true;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Visibility(
                            visible: _isVisible ? true : false,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = false;
                                  _focusNode.unfocus();
                                });
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.xmark,
                              ),
                            ),
                          ),
                          prefixIcon: SizedBox(
                            width: 25.r,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                              ),
                            ),
                          ),
                          hintText: "Pesquisar por documento",
                          labelText: "Pesquisar por documento",
                        ),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: Material(
                          elevation: 5.r,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.r,
                              vertical: 8.r,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Período de busca",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  RadioListTile.adaptive(
                                    value: "date_created",
                                    groupValue: _groupValue,
                                    onChanged: (selected) {
                                      setState(() {
                                        _groupValue = selected!;
                                      });
                                    },
                                    title: Text(
                                      "Data de criação",
                                    ),
                                  ),
                                  RadioListTile.adaptive(
                                    value: "signed_date",
                                    groupValue: _groupValue,
                                    secondary: Container(
                                      color: Colors.blueAccent.withOpacity(.25),
                                      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 2.r),
                                      child: Text(
                                        "Novo",
                                        style: GoogleFonts.nunito(fontSize: 12.sp, fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    onChanged: (selected) {
                                      setState(() {
                                        _groupValue = selected!;
                                      });
                                    },
                                    title: Text(
                                      "Data de assinatura",
                                    ),
                                  ),
                                  PopupMenuButton(
                                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 80.r),
                                    position: PopupMenuPosition.under,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.r),
                                      width: double.infinity,
                                      height: 50.h,
                                      color: Color(0xFFE5E5E5),
                                      child: ListTile(
                                        title: Text(_periodo),
                                        trailing: Padding(
                                          padding: EdgeInsets.only(bottom: 7.r),
                                          child: FaIcon(
                                            FontAwesomeIcons.sortDown,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelected: (selected) {
                                      setState(() {
                                        _periodo = selected;
                                      });
                                    },
                                    itemBuilder: (_) => [
                                      PopupMenuItem(
                                        value: "Selecione o período",
                                        child: Text("Selecione o período"),
                                      ),
                                      PopupMenuItem(
                                        value: "Últimas 24 horas",
                                        child: Text("Últimas 24 horas"),
                                      ),
                                      PopupMenuItem(
                                        value: "Últimos 7 dias",
                                        child: Text("Últimos 7 dias"),
                                      ),
                                      PopupMenuItem(
                                        value: "Últimos 30 dias",
                                        child: Text("Últimos 30 dias"),
                                      ),
                                      PopupMenuItem(
                                        value: "Últimos 6 meses",
                                        child: Text("Últimos 6 meses"),
                                      ),
                                      PopupMenuItem(
                                        value: "Últimos 12 meses",
                                        child: Text("Últimos 12 meses"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.r,
                                  ),
                                  Text(
                                    "Autor do documento",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.r,
                                  ),
                                  SizedBox(
                                    height: 45.h,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Buscar usuários",
                                        labelText: "Buscar usuários",
                                      ),
                                    ),
                                  ),
                                  CheckboxListTile.adaptive(
                                    value: _sameFolder,
                                    onChanged: (value) {
                                      setState(() {
                                        _sameFolder = value ?? false;
                                      });
                                    },
                                    title: Text(
                                      "Buscar somente nesta pasta",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50.h,
        child: Row(
          children: [
            AnimatedContainer(
              width: _currentIndex == 0 ? MediaQuery.of(context).size.width * .75 : MediaQuery.of(context).size.width * .25,
              duration: Duration(
                milliseconds: 350,
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentIndex == 0 ? Colors.blueAccent : Colors.white,
                  shape: ContinuousRectangleBorder(),
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                label: _currentIndex == 0 ? Text("Documentos") : SizedBox(),
                icon: FaIcon(
                  FontAwesomeIcons.file,
                  color: _currentIndex == 1 ? Colors.blueAccent : Colors.white,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(
                milliseconds: 350,
              ),
              width: _currentIndex == 1 ? MediaQuery.of(context).size.width * .75 : MediaQuery.of(context).size.width * .25,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentIndex == 1 ? Colors.blueAccent : Colors.white,
                  shape: ContinuousRectangleBorder(),
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                label: _currentIndex == 1 ? Text("Pastas") : SizedBox(),
                icon: FaIcon(
                  FontAwesomeIcons.folder,
                  color: _currentIndex == 0 ? Colors.blueAccent : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pasta extends StatefulWidget {
  final String nomeDaPasta;

  const Pasta({super.key, required this.nomeDaPasta});

  @override
  State<Pasta> createState() => _PastaState();
}

class _PastaState extends State<Pasta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pasta / ${widget.nomeDaPasta}",
        ),
      ),
      body: Center(
        child: Text(
          "${widget.nomeDaPasta}",
        ),
      ),
    );
  }
}
