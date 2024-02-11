import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/casilla.dart';
import 'package:dev_tesis/game/components/player.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/banner_info_actividades.dart';
import 'package:dev_tesis/ui/widgets/response_game_flame.dart';
import 'package:dev_tesis/ui/widgets/tablero_cuestionario.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActividadCuestionarioScreen extends StatefulWidget {
  const ActividadCuestionarioScreen({super.key});

  @override
  State<ActividadCuestionarioScreen> createState() =>
      _ActividadCuestionarioScreenState();
}

class _ActividadCuestionarioScreenState
    extends State<ActividadCuestionarioScreen> {
  final GameActivity game = GameActivity();
  @override
  Widget build(BuildContext context) {
    final movementInstructionsCubit = context.watch<InstruccionesCubit>();
    Player player = game.player;
    return Scaffold(
      appBar: const CustomAppBar(userName: 'usuario'),
      // Responsive UI design for desktop and mobile
      body: MediaQuery.of(context).size.width > 700
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: blueColor,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const IntrinsicHeight(
                            child: BannerInfoActividades(),
                          ),
                          Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Add content for the left section of the blue board
                                      SizedBox(
                                        width: 800,
                                        height: 800,
                                        child: TableroCuestionario(
                                          actividadCuestionario:
                                              ActividadCuestionario(
                                            id: "1",
                                            nombre: "Cuestionario 1",
                                            descripcion:
                                                "Descripción del cuestionario",
                                            estado: 'Activa',
                                            tipoActividad: "Cuestionario",
                                            dimension: 5,
                                            casillaGanadora: 3,
                                            casillaInicio: 0,
                                            casillas: [
                                              Casilla(
                                                id: "1",
                                                numeroCasilla: 1,
                                                tipoCasilla: "Normal",
                                                recurso:
                                                    "avatares/aguila_avatar.png",
                                              ),
                                              Casilla(
                                                id: "1",
                                                numeroCasilla: 10,
                                                tipoCasilla: "Normal",
                                                recurso:
                                                    "avatares/cafe_avatar.png",
                                              ),
                                              // Otras casillas...
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        //color: Colors.green,
                                        margin: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        height: 250,
                                        child: Stack(
                                          children: [
                                            FractionallySizedBox(
                                              heightFactor: 0.6,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                    "El granjero necesita de tu ayuda \n!Guíalo para que encuentre a sus GALLINAS ",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 30,
                                              bottom: 0,
                                              child: Image.asset(
                                                  'assets/friends/Pajarito-colombiano.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 150,
                                                  height: 150),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 20),
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
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion(
                                                        'arriba');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Arriba.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion('abajo');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Abajo.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion(
                                                        'izquierda');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Izquierda.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion(
                                                        'derecha');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Derecha.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const RespuestaLaberinto(),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 30,
                                            right: 30,
                                            left:
                                                30), // Puedes ajustar el valor según tus necesidades
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              child: PixelLargeBttn(
                                                  path:
                                                      "assets/buttons/Play.png",
                                                  text: '',
                                                  onPressed: () async {
                                                    player.movementInstructions =
                                                        movementInstructionsCubit
                                                            .state
                                                            .map((map) =>
                                                                map.key)
                                                            .toList();
                                                    Future<bool> response =
                                                        player
                                                            .executeResponse();
                                                    if (await response) {
                                                      Future.delayed(
                                                          Duration(seconds: 2),
                                                          () {
                                                        // ignore: use_build_context_synchronously
                                                        _mostrarDialogoVictoria(
                                                            context);
                                                      });
                                                    }
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 60,
                                              child: PixelLargeBttn(
                                                  path:
                                                      "assets/buttons/Clean.png",
                                                  text: '',
                                                  onPressed: () async {
                                                    movementInstructionsCubit
                                                        .limpiarInstrucciones();
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: blueColor,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const IntrinsicHeight(
                            child: BannerInfoActividades(),
                          ),
                          Center(
                            child: Column(
                              children: [
                                // Add content for the left section of the blue board

                                Container(
                                  //color: Colors.green,
                                  margin: const EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 250,
                                  child: Stack(
                                    children: [
                                      FractionallySizedBox(
                                        heightFactor: 0.6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                              "El granjero necesita de tu ayuda \n!Guíalo para que encuentre a sus GALLINAS ",
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
                                        right: 30,
                                        bottom: 30,
                                        child: Image.asset(
                                            'assets/friends/Pajarito-colombiano.png', // Reemplaza con la ruta de tu imagen en assets
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, bottom: 20),
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
                                SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child: GameWidget(game: game),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          movementInstructionsCubit
                                              .agregarIntruccion('arriba');
                                        },
                                        iconSize: 100,
                                        icon: Image.asset(
                                            'assets/buttons/Arriba.png', // Reemplaza con la ruta de tu imagen en assets
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          movementInstructionsCubit
                                              .agregarIntruccion('abajo');
                                        },
                                        iconSize: 100,
                                        icon: Image.asset(
                                            'assets/buttons/Abajo.png', // Reemplaza con la ruta de tu imagen en assets
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          movementInstructionsCubit
                                              .agregarIntruccion('izquierda');
                                        },
                                        iconSize: 100,
                                        icon: Image.asset(
                                            'assets/buttons/Izquierda.png', // Reemplaza con la ruta de tu imagen en assets
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          movementInstructionsCubit
                                              .agregarIntruccion('derecha');
                                        },
                                        iconSize: 100,
                                        icon: Image.asset(
                                            'assets/buttons/Derecha.png', // Reemplaza con la ruta de tu imagen en assets
                                            fit: BoxFit.cover,
                                            width: 50,
                                            height: 50),
                                      ),
                                    ],
                                  ),
                                ),

                                const RespuestaLaberinto(),

                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 30,
                                  ), // Puedes ajustar el valor según tus necesidades
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: PixelLargeBttn(
                                            path: "assets/buttons/Play.png",
                                            text: '',
                                            onPressed: () async {
                                              player.movementInstructions =
                                                  movementInstructionsCubit
                                                      .state
                                                      .map((map) => map.key)
                                                      .toList();
                                              Future<bool> response =
                                                  player.executeResponse();
                                              if (await response) {
                                                Future.delayed(
                                                    Duration(seconds: 2), () {
                                                  // ignore: use_build_context_synchronously
                                                  _mostrarDialogoVictoria(
                                                      context);
                                                });
                                              }
                                            }),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: PixelLargeBttn(
                                            path: "assets/buttons/Clean.png",
                                            text: '',
                                            onPressed: () async {
                                              movementInstructionsCubit
                                                  .limpiarInstrucciones();
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _mostrarDialogoVictoria(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Haz llegado a la meta'),
          content: Text(
              'El granjero ha encontrado a sus GALLINAS y esta muy agradecido contigo, !te ha dado un cafeto como recompensa!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                // Lógica para limpiar las instrucciones
                context.read<InstruccionesCubit>().limpiarInstrucciones();
              },
              child: Text('Seguir aprendiendo'),
            ),
          ],
        );
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const CustomAppBar({Key? key, required this.userName}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Mundo PC'),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Opción 1'),
                value: 'Opción 1',
              ),
              PopupMenuItem(
                child: Text('Opción 2'),
                value: 'Opción 2',
              ),
              // Add more PopupMenuItems as needed
            ];
          },
          onSelected: (value) {
            // Handle selection
          },
        ),
      ],
    );
  }
}
