import 'package:dev_tesis/ui/pages/scren_crear_curso/crear_curso_mobile_screen.dart';
import 'package:dev_tesis/ui/pages/scren_crear_curso/crear_curso_web_screen.dart';
import 'package:flutter/material.dart';

class CrearCursoScreen extends StatefulWidget {
  const CrearCursoScreen({super.key});

  @override
  State<CrearCursoScreen> createState() => _CrearCursoScreenState();
}

class _CrearCursoScreenState extends State<CrearCursoScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth >= 700) {
        // Versión de escritorio
        return const CrearCursoWebScreen();
      } else {
        // Versión móvil
        return const CrearCursoMobileScreen();
      }
    });
  }
}
