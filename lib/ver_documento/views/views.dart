import "package:flutter/material.dart";

class VerDocumento extends StatefulWidget {
  const VerDocumento({super.key});

  @override
  State<VerDocumento> createState() => _VerDocumentoState();
}

class _VerDocumentoState extends State<VerDocumento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver documento"),
      ),
    );
  }
}
