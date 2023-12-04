import 'package:dev_tesis/game/game_activity.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Nivel1Laberinto extends StatefulWidget {
  const Nivel1Laberinto({super.key});

  @override
  State<Nivel1Laberinto> createState() => _Nivel1LaberintoState();
}

class _Nivel1LaberintoState extends State<Nivel1Laberinto> {
  final GameActivity game = GameActivity();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "Hola, esta es una actividad",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 76, 198, 255),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 600,
                        height: 600,
                        child: GameWidget(
                            game: kDebugMode ? GameActivity() : game),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            //color: Colors.green,
                            margin: EdgeInsets.all(30),
                            width: double.infinity,
                            height: 250,
                            child: Stack(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 0.85,
                                  heightFactor: 0.6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      margin: EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 60,
                                          bottom: 20),
                                      child: Text(
                                        "Bienvenido Gamer a la actividad de laberinto. \n\nÉl granjero necesita de tu ayuda !Guíalo a encontrar a sus GALLINAS ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -30,
                                  bottom: 0,
                                  child: Image.asset(
                                      'assets/friends/Pajarito-colombiano.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(30),
                            child: Text(
                              "Selecciona los pasos necesarios para\nllegar a la meta:",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Image.asset(
                                      'assets/buttons/Avanzar.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                                Container(
                                  child: Image.asset(
                                      'assets/buttons/GirarDerecha.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                                Container(
                                  child: Image.asset(
                                      'assets/buttons/GirarIzq.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                                Container(
                                  child: Image.asset(
                                      'assets/buttons/Repetir.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(30),
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
