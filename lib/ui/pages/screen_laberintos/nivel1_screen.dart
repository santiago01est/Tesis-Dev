import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';

class Nivel1Laberinto extends StatefulWidget {
  const Nivel1Laberinto({super.key});

  @override
  State<Nivel1Laberinto> createState() => _Nivel1LaberintoState();
}

class _Nivel1LaberintoState extends State<Nivel1Laberinto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nivel 1',
        ),
      ),
    );
  }
}
