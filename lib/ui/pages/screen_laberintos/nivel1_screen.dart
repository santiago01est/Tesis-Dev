import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/widgets/banner_info_actividades.dart';
import 'package:dev_tesis/ui/widgets/response_game_flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Laberinto extends StatefulWidget {
  final String actividadId;
  const Laberinto({super.key, required this.actividadId});

  @override
  State<Laberinto> createState() => _LaberintoState();
}

class _LaberintoState extends State<Laberinto> {
  int calificacion = -1;
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final unidadesCubit = context.read<UnidadesCubit>();
    final seguimientosCubit = context.read<SeguimientosEstudiantesCubit>();

    final estudiantes = context.read<EstudiantesCubit>();
    final curso = context.read<CursoCubit>();
    ActividadLaberinto? actividadLaberinto;
    for (var unidad in curso.state.unidades!) {
      // Verifica si la unidad actual tiene la actividad a eliminar
      if (unidad.actividades != null) {
        // for que recorre las actividades

        for (Actividad actividad in unidad.actividades!) {
          if (actividad.id == widget.actividadId) {
            if (actividad is ActividadLaberinto) {
              actividadLaberinto = actividad;
            }
          }
        }
      }
    }

    final movementInstructionsCubit = context.read<InstruccionesCubit>();
    final GameActivity game = GameActivity(actividadLaberinto == null
        ? 'Laberinto1'
        : actividadLaberinto.nombreArchivo!);
    Player player = game.player;

    String nombreUnidad =
        unidadesCubit.nombreUnidadDeActividad(actividadLaberinto!.id!);
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
                          IntrinsicHeight(
                            child: BannerInfoActividades(
                              indice: actividadLaberinto.indice!,
                              habilidades: [0, 0, 0, 1],
                              titulo:
                                  '$nombreUnidad \n${actividadLaberinto.nombre!}',
                            ),
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
                                        child: GameWidget(game: game),
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
                                                  child: Text(
                                                    actividadLaberinto!
                                                        .descripcion!,
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
                                                        'avanzar');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Derecha.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60),
                                            ),
                                            if (true) ...[
                                              IconButton(
                                                onPressed: () {
                                                  movementInstructionsCubit
                                                      .agregarIntruccion(
                                                          'giroDeIzquierda');
                                                },
                                                iconSize: 100,
                                                icon: Image.asset(
                                                    'assets/buttons/GirarIzq.png', // Reemplaza con la ruta de tu imagen en assets
                                                    fit: BoxFit.cover,
                                                    width: 60,
                                                    height: 60),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  movementInstructionsCubit
                                                      .agregarIntruccion(
                                                          'giroDeDerecha');
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
                                                      .agregarIntruccion(
                                                          'recoger');
                                                },
                                                iconSize: 100,
                                                icon: Image.asset(
                                                    'assets/buttons/Agarrar.png', // Reemplaza con la ruta de tu imagen en assets
                                                    fit: BoxFit.cover,
                                                    width: 60,
                                                    height: 60),
                                              ),
                                            ]
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
                                            Wrap(
                                              children: [
                                                SizedBox(
                                                  height: 40,
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
                                                        int response = await player
                                                            .processMovementInstructionsResponse();
                                                        print(response);
                                                        if (true) {
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 2),
                                                              () {
                                                            // ignore: use_build_context_synchronously
                                                            _mostrarDialogoVictoria(
                                                                context,
                                                                router,
                                                                unidadesCubit,
                                                                actividadLaberinto!);
                                                          });
                                                          seguimientosCubit.actualizarRespuestasActividadesEstudiantes(
                                                              estudiantes
                                                                  .obtenerIds(),
                                                              response,
                                                              unidadesCubit
                                                                  .indiceActividadPorId(
                                                                      actividadLaberinto!
                                                                          .id!)!);
                                                          print(seguimientosCubit
                                                              .state
                                                              .map((e) => e
                                                                  .respuestasActividades));
                                                        }
                                                      }),
                                                ),
                                                const SizedBox(width: 20),
                                                SizedBox(
                                                    height: 40,
                                                    child: PixelLargeBttn(
                                                        path:
                                                            "assets/buttons/Reiniciar.png",
                                                        text: '',
                                                        onPressed: () {}))
                                              ],
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
                          IntrinsicHeight(
                            child: BannerInfoActividades(
                              indice: actividadLaberinto.indice!,
                              habilidades: [0, 0, 0, 1],
                              titulo:
                                  '$nombreUnidad \n${actividadLaberinto!.nombre!}',
                            ),
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
                                            child: Text(
                                              actividadLaberinto!.descripcion!,
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
                                    "Presiona los pasos necesarios para lograr tu objetivo:",
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
                                      Row(
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
                                                  final response = player
                                                      .processMovementInstructionsResponse();
                                                  print(response);
                                                  if (true) {
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      // ignore: use_build_context_synchronously
                                                      _mostrarDialogoVictoria(
                                                          context,
                                                          router,
                                                          unidadesCubit,
                                                          actividadLaberinto!);
                                                    });
                                                  }
                                                }),
                                          ),
                                          const SizedBox(width: 20),
                                          SizedBox(
                                              height: 40,
                                              child: PixelLargeBttn(
                                                  path:
                                                      "assets/buttons/Reiniciar.png",
                                                  text: '',
                                                  onPressed: () {}))
                                        ],
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

  int obtenerPesoActividad(int respuestaEstudiante, String id) {
    final unidad = context.read<UnidadesCubit>();
    Actividad actividad = unidad.actividadPorId(id)!;

    // toast

    if (respuestaEstudiante == -1) {
      return 0;
    } else {
      return actividad.pesoRespuestas![respuestaEstudiante - 1];
    }
  }

  void _mostrarDialogoVictoria(BuildContext context, GoRouter router,
      UnidadesCubit unidadesCubit, ActividadLaberinto actividadLaberinto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bien Hecho!! 🏆 Haz llegado a tu Objetivo'),
          content: const Text('Continuemos con la siguiente Actividad!'),
          actions: <Widget>[
            PixelLargeBttn(
              path: "assets/items/ButtonOrange.png",
              text: 'Volver al Curso',
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            PixelLargeBttn(
              path: "assets/items/ButtonBlue.png",
              text: 'Siguiente',
              onPressed: () {
                SiguienteActividadInfo siguienteActividadInfo = unidadesCubit
                    .siguienteActividadInfo(actividadLaberinto.id!);
                if (context
                    .read<UnidadesCubit>()
                    .esUltimaActividadGlobal(actividadLaberinto.id!)) {
                  router.push(
                      '/testautopercepcion/${context.read<CursoCubit>().state.id}');
                } else {
                  if (siguienteActividadInfo.tipoActividad == "Laberinto") {
                    router.push(
                        '/laberinto/${siguienteActividadInfo.idActividad}');
                  } else if (siguienteActividadInfo.tipoActividad ==
                      "Cuestionario") {
                    router.push(
                        '/cuestionario/${siguienteActividadInfo.idActividad}');
                  }
                }

                Navigator.of(context).pop(); // Cierra el diálogo
              },
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
