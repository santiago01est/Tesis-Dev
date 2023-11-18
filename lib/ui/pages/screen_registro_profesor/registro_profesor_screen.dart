import 'package:dev_tesis/ui/pages/screen_registro_profesor/inicio_sesion_mobile_scree.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/inicio_sesion_web_screen.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/registro_profesor_mobile_screen.dart';
import 'package:dev_tesis/ui/pages/screen_registro_profesor/registro_profesor_web_screen.dart';
import 'package:flutter/material.dart';

class RegistroProfesorScreen extends StatelessWidget {
  const RegistroProfesorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth >= 900) {
        // Versión de escritorio
        return const RegistroProfesorWebScreen();
      } else {
        // Versión móvil
        return const RegistroProfesorMobileScreen();
      }
    });
  }
}
