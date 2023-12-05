import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/response_game_flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Nivel1Laberinto extends StatefulWidget {
  const Nivel1Laberinto({super.key});

  @override
  State<Nivel1Laberinto> createState() => _Nivel1LaberintoState();
}

class _Nivel1LaberintoState extends State<Nivel1Laberinto> {
  final GameActivity game = GameActivity();

  @override
  Widget build(BuildContext context) {
    final movementInstructionsCubit = context.watch<InstruccionesCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const TitleText(
                text: 'Nivel 1 - Laberinto',
              ),
            ),
            Container(
              margin: const EdgeInsets.all(32),
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
                              game: game),
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
                              margin: const EdgeInsets.all(30),
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
                                        margin: const EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 60,
                                            bottom: 20),
                                        child: const Text(
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
                              margin: const EdgeInsets.all(30),
                              child: const Text(
                                "Selecciona los pasos necesarios para\nllegar a la meta:",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    movementInstructionsCubit
                                        .agregarIntruccion('Avanzar');
                                  },
                                  iconSize: 100,
                                  icon: Image.asset(
                                      'assets/buttons/Avanzar.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                                IconButton(
                                  onPressed: () {
                                    movementInstructionsCubit
                                        .agregarIntruccion('Girar Derecha');
                                  },
                                  iconSize: 100,
                                  icon: Image.asset(
                                      'assets/buttons/GirarDerecha.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                                IconButton(
                                  onPressed: () {
                                    movementInstructionsCubit
                                        .agregarIntruccion('Girar Izquierda');
                                  },
                                  iconSize: 100,
                                  icon: Image.asset(
                                      'assets/buttons/GirarIzq.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  iconSize: 100,
                                  icon: Image.asset(
                                      'assets/buttons/Repetir.png', // Reemplaza con la ruta de tu imagen en assets
                                      fit: BoxFit.cover,
                                      width: 60,
                                      height: 60),
                                ),
                              ],
                            ),
                            RespuestaLaberinto(),
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
      ),
    );
  }
}
