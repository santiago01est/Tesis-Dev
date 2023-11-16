import 'package:dev_tesis/ui/widgets/login_form.dart';
import 'package:dev_tesis/ui/widgets/web_layout.dart';
import 'package:flutter/material.dart';

class InicioSesionWebScreen extends StatefulWidget {
  const InicioSesionWebScreen({super.key});

  @override
  State<InicioSesionWebScreen> createState() => _InicioSesionWebScreenState();
}

class _InicioSesionWebScreenState extends State<InicioSesionWebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/FondoIniciosesion.png'), // Ruta de tu imagen
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: buildWelcomeContent(),
        ),
      ],
    ));
  }
}

Widget buildWelcomeContent() {
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
              dataWidget: LoginForm(),
            )),
      ],
    ),
  )));
}
