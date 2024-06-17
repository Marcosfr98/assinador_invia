import "package:assinador_invia/login/controllers/controllers.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final MyLoginController _controller = MyLoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Builder(builder: (context) {
          return SingleChildScrollView(
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Image.asset("assets/images/logo.png"),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Insira o seu nome de usuário",
                            labelText: "Nome de usuário",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Flexible(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) => TextFormField(
                            obscureText: _controller.isObscure,
                            decoration: InputDecoration(
                              hintText: "Insira a sua senha",
                              labelText: "Senha",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _controller
                                      .setIsObscure(!_controller.isObscure);
                                },
                                icon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.remove_red_eye),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Esqueci minha senha"),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Fazer Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
