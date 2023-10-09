import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Image.asset(
          'assets/Inicio.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
