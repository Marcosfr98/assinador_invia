import "package:flutter/material.dart";

class AssinaturaRapida extends StatefulWidget {
  const AssinaturaRapida({super.key});

  @override
  State<AssinaturaRapida> createState() => _AssinaturaRapidaState();
}

class _AssinaturaRapidaState extends State<AssinaturaRapida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assainatura rápida"),
      ),
      body: Center(
        child: Text("Assinatura rápida"),
      ),
    );
  }
}
