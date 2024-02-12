import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';

class BannerInfoActividades extends StatelessWidget {
  const BannerInfoActividades({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            10.0), // Bordes redondos para la imagen de fondo
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.9,
              child: Image.asset(
                'assets/fondos/FondoInicio.png',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Título
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TitleText(
                    text: 'Actividad 1: \nUn mundo por explorar',
                    color: Colors.white,
                  ),
                ),
                //si la pantalla es menor a 880 es un dispositivo movil y el padding no se visualiza
                MediaQuery.of(context).size.width < 880
                    ? Container()
                    : (
                        // Lista de mini tarjetas con tags
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TagMiniCard(text: 'Algoritmo'),
                            TagMiniCard(text: 'Patrones'),
                            TagMiniCard(text: 'Descomposicion'),
                            TagMiniCard(text: 'Abstracción')
                          ],
                        ),
                      )),
                // Icono informativo
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TagMiniCard extends StatelessWidget {
  final String text;

  const TagMiniCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}
