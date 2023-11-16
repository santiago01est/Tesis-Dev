import 'package:dev_tesis/ui/pages/screen_registro_profesor/inicio_sesion_web_screen.dart';
import 'package:flutter/material.dart';

class InicioSesionScreen extends StatelessWidget {
  const InicioSesionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth >= 900) {
        // Versión de escritorio
        return const InicioSesionWebScreen();
      } else {
        // Versión móvil
        return const InicioSesionWebScreen();
      }
    });
  }
}
