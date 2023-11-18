import 'package:dev_tesis/ui/widgets/registro_form_web.dart';
import 'package:dev_tesis/ui/widgets/web_iniciosesion_layout.dart';
import 'package:flutter/material.dart';

class RegistroProfesorMobileScreen extends StatefulWidget {
  const RegistroProfesorMobileScreen({super.key});

  @override
  State<RegistroProfesorMobileScreen> createState() =>
      _RegistroProfesorMobileScreenState();
}

class _RegistroProfesorMobileScreenState
    extends State<RegistroProfesorMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20), // Espacio entre el mensaje y la Card
          Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // Using LayoutBuilder for responsive UI design
              child: WebLayout(
                dataWidget: RegistroFormWeb(),
              )),
        ],
      ),
    )));
  }
}

Widget registroSeccion() {
  return Scaffold(
      body: Center(
          child: SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 20), // Espacio entre el mensaje y la Card
        Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            // Using LayoutBuilder for responsive UI design
            child: WebLayout(
              dataWidget: RegistroFormWeb(),
            )),
      ],
    ),
  )));
}
