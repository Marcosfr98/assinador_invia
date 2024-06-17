import 'package:flutter/material.dart';

class HomePageController {
  static final List<TextEditingController> nomeController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  static final List<TextEditingController> emailController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  static final List<TextEditingController> telefoneController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  static final List<TextEditingController> cpfController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  get formKey => _formKey;
  var _formKey = GlobalKey<FormState>();
  static List<bool> hasSigner = [false, false, false, false, false];
  static int numberOfSigners = 1;
}
