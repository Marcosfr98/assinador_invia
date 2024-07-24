import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/controllers.dart';
import '../../services/api.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _myLoginPageController = MyLoginPageController.instance;
  final _myLoginPageService = MyLoginServiceApi.instance;
  final _usernameController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom >= 20
              ? MediaQuery.of(context).viewInsets.bottom
              : 0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.r,
                    ),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Fazer login",
                            style: GoogleFonts.montserrat(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8.r,
                          ),
                          Text(
                            "Entre na sua conta e aproveite esta solução para assinaturas digitais",
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 16.r,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Campo usuário não pode ser vazio!";
                              } else {
                                return null;
                              }
                            },
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: "Insira o seu nome de usuário",
                              labelText: "Nome de usuário",
                            ),
                          ),
                          SizedBox(
                            height: 24.r,
                          ),
                          TextFormField(
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Campo senha não pode ser vazio!";
                              } else {
                                return null;
                              }
                            },
                            controller: _senhaController,
                            decoration: InputDecoration(
                              suffixIcon: SizedBox(
                                width: 50.r,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.eye,
                                    ),
                                  ),
                                ),
                              ),
                              hintText: "Insira a sua senha",
                              labelText: "Senha",
                            ),
                          ),
                          SizedBox(
                            height: 24.r,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  side: BorderSide(
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    "Lembrar de mim",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      textStyle: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                  )),
                                  onPressed: () {},
                                  child: Text(
                                    "Esqueci minha senha",
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.r,
                        vertical: 24.r,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: AnimatedBuilder(
                            animation: _myLoginPageController,
                            builder: (context, child) {
                              return ElevatedButton(
                                child: _myLoginPageController.isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text("Fazer Login"),
                                onPressed: _myLoginPageController.isLoading
                                    ? () {}
                                    : () async {
                                        _myLoginPageController.isLoading = true;
                                        await _myLoginPageService.login(
                                          username: _usernameController.text,
                                          password: _senhaController.text,
                                        );
                                        _myLoginPageController.isLoading =
                                            false;
                                      },
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
