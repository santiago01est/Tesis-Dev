import 'package:dev_tesis/ui/widgets/registro_form_web.dart';
import 'package:dev_tesis/ui/widgets/web_iniciosesion_layout.dart';
import 'package:flutter/material.dart';

class RegistroProfesorWebScreen extends StatefulWidget {
  const RegistroProfesorWebScreen({super.key});

  @override
  State<RegistroProfesorWebScreen> createState() =>
      _RegistroProfesorWebScreenState();
}

class _RegistroProfesorWebScreenState extends State<RegistroProfesorWebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          flex: 1,
          child: registroSeccion(),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/fondos/FondoRegistroProfesor.png'), // Ruta de tu imagen
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ));
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
