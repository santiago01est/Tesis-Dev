import 'package:dev_tesis/ui/widgets/login_form_mobile.dart';
import 'package:dev_tesis/ui/widgets/login_form_web.dart';
import 'package:dev_tesis/ui/widgets/mobile_iniciosesion_layout.dart';
import 'package:flutter/material.dart';

class InicioSesionMobileScreen extends StatefulWidget {
  const InicioSesionMobileScreen({super.key});

  @override
  State<InicioSesionMobileScreen> createState() =>
      _IncioSesionMobileScreenState();
}

class _IncioSesionMobileScreenState extends State<InicioSesionMobileScreen> {
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
              child: MobileLayout(
                dataWidget: LoginFormMobile(),
              )),
        ],
      ),
    )));
  }
}
