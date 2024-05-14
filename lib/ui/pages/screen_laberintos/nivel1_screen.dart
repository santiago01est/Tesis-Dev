import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_actividad.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/widgets/banner_info_actividades.dart';
import 'package:dev_tesis/ui/widgets/response_game_flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Laberinto extends StatefulWidget {
  final int actividadId;
  const Laberinto({super.key, required this.actividadId});

  @override
  State<Laberinto> createState() => _LaberintoState();
}

class _LaberintoState extends State<Laberinto> {
  CursosCasoUso cursoCs = getIt<CursosCasoUso>();
  int calificacion = -1;
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final unidadesCubit = context.read<UnidadesCubit>();
    final seguimientosCubit = context.read<SeguimientosEstudiantesCubit>();
    final curso = context.read<CursoCubit>();

    final estudiantes = context.read<EstudiantesCubit>();
    List<String> avatares = [];
    for (var estudiante in estudiantes.state) {
      avatares.add(estudiante.avatar!);
    }

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
    actividadLaberinto == null
        ? game.player.chargeInitialState(0)
        : game.player.chargeInitialState(actividadLaberinto.initialState!);

    String nombreUnidad =
        unidadesCubit.nombreUnidadDeActividad(actividadLaberinto!.id!);
    String nombreArchivo = actividadLaberinto.nombreArchivo!;
    movementInstructionsCubit.limpiarInstrucciones();
    return Scaffold(
      appBar: CustomNavigationBarActividad(
        cursoName: 'Mundo PC',
        cursoId: curso.state.id!,
        userName: estudiantes.obtenerNombres(),
        userAvatars: avatares,
        onLogout: () {
          // Aquí implementa la lógica para cerrar sesión
          print('Cerrar sesión');
        },
      ),
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
                              isDiagnostico:
                                  actividadLaberinto.nombre! == 'Diagnostico',
                              habilidades: actividadLaberinto.habilidades!,
                              titulo:
                                  '$nombreUnidad \nActividad ${unidadesCubit.obtenerIndiceActividadEnUnidad(actividadLaberinto.id!)! + 1}',
                            ),
                          ),
                          Center(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                    actividadLaberinto
                                                        .descripcion!,
                                                    style: const TextStyle(
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
                                        child: Wrap(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion(
                                                        'avanzar', 'avanzar');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Avanzar.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60),
                                            ),
                                            if (nombreArchivo !=
                                                'Laberinto1') ...[
                                              IconButton(
                                                onPressed: () {
                                                  movementInstructionsCubit
                                                      .agregarIntruccion(
                                                          'giroDeIzquierda',
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
                                                          'giroDeDerecha',
                                                          'giroDeDerecha');
                                                },
                                                iconSize: 100,
                                                icon: Image.asset(
                                                    'assets/buttons/GirarDerecha.png', // Reemplaza con la ruta de tu imagen en assets
                                                    fit: BoxFit.cover,
                                                    width: 60,
                                                    height: 60),
                                              ),
                                              if (nombreArchivo !=
                                                      'Laberinto2' &&
                                                  nombreArchivo !=
                                                      'Laberinto5') ...[
                                                IconButton(
                                                  onPressed: () {
                                                    movementInstructionsCubit
                                                        .agregarIntruccion(
                                                            'recoger',
                                                            'recoger');
                                                  },
                                                  iconSize: 100,
                                                  icon: Image.asset(
                                                      'assets/buttons/Agarrar.png', // Reemplaza con la ruta de tu imagen en assets
                                                      fit: BoxFit.cover,
                                                      width: 60,
                                                      height: 60),
                                                ),
                                                if (nombreArchivo
                                                    .contains('5')) ...[
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'avanzar',
                                                        'avanzar',
                                                        'avanzar',
                                                        'avanzar',
                                                        'avanzar'
                                                      ], 'Nivel 1');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 1.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                ],
                                                if (nombreArchivo
                                                    .contains('6')) ...[
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                      ], 'Nivel 2');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 2.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                      ], 'Nivel 2-X');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 2-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                ],
                                                if (nombreArchivo
                                                    .contains('7')) ...[
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeIzquierda'
                                                      ], 'Nivel 3');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 3.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'avanzar',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'avanzar',
                                                        'avanzar'
                                                      ], 'Nivel 3-X');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 3-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                ],
                                                if (nombreArchivo
                                                    .contains('8')) ...[
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'giroDeDerecha',
                                                        'giroDeDerecha',
                                                      ], 'Nivel 4');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 4.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar'
                                                            'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar'
                                                      ], 'Nivel 4-X');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 4-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                ],
                                                if (nombreArchivo
                                                        .contains('6') ||
                                                    nombreArchivo
                                                        .contains('7') ||
                                                    nombreArchivo
                                                        .contains('8')) ...[
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'avanzar',
                                                        'avanzar',
                                                        'avanzar',
                                                      ], 'Nivel 2, 3 y 4');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 2, 3 y 4.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                ],
                                                if (nombreArchivo
                                                        .contains('7') ||
                                                    nombreArchivo
                                                        .contains('8')) ...[
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'avanzar',
                                                        'avanzar',
                                                      ], 'Nivel 3 y 4');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 3 y 4.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      movementInstructionsCubit
                                                          .agregarIntruccion([
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                        'giroDeIzquierda',
                                                        'avanzar',
                                                        'giroDeDerecha',
                                                        'avanzar',
                                                      ], 'Nivel 3 y 4-X');
                                                    },
                                                    iconSize: 100,
                                                    icon: Image.asset(
                                                        'assets/buttons/Nivel 3 y 4-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                        fit: BoxFit.cover,
                                                        height: 60),
                                                  ),
                                                ]
                                              ]
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
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
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
                                                            .expand((map) {
                                                      if (map.key
                                                          is List<String>) {
                                                        return map.key
                                                            as List<String>;
                                                      } else {
                                                        return [
                                                          map.key as String
                                                        ];
                                                      }
                                                    }).toList();
                                                    List respuestaGeneral =
                                                        movementInstructionsCubit
                                                            .state
                                                            .map((e) => e.key)
                                                            .toList();

                                                    int response = await player
                                                        .processMovementInstructionsResponse(
                                                            respuestaGeneral,
                                                            actividadLaberinto!
                                                                .mejorCamino!,
                                                            actividadLaberinto
                                                                .mejorCamino2);
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
                                                            actividadLaberinto!,
                                                            seguimientosCubit,
                                                            estudiantes,
                                                            curso.state.id!,
                                                            response);
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
                                            SizedBox(
                                                height: 50,
                                                child: PixelLargeBttn(
                                                    path:
                                                        "assets/buttons/Reiniciar.png",
                                                    text: '',
                                                    onPressed: () {
                                                      player.reiniciar();
                                                      movementInstructionsCubit
                                                          .limpiarInstrucciones();
                                                    }))
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
                              isDiagnostico:
                                  actividadLaberinto.nombre! == 'Diagnostico',
                              habilidades: actividadLaberinto.habilidades!,
                              titulo:
                                  '$nombreUnidad \n${actividadLaberinto.nombre!}',
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
                                              actividadLaberinto.descripcion!,
                                              style: const TextStyle(
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
                                  child: Wrap(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          movementInstructionsCubit
                                              .agregarIntruccion(
                                                  'avanzar', 'avanzar');
                                        },
                                        iconSize: 100,
                                        icon: Image.asset(
                                            'assets/buttons/Avanzar.png', // Reemplaza con la ruta de tu imagen en assets
                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 60),
                                      ),
                                      if (nombreArchivo != 'Laberinto1') ...[
                                        IconButton(
                                          onPressed: () {
                                            movementInstructionsCubit
                                                .agregarIntruccion(
                                                    'giroDeIzquierda',
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
                                                    'giroDeDerecha',
                                                    'giroDeDerecha');
                                          },
                                          iconSize: 100,
                                          icon: Image.asset(
                                              'assets/buttons/GirarDerecha.png', // Reemplaza con la ruta de tu imagen en assets
                                              fit: BoxFit.cover,
                                              width: 60,
                                              height: 60),
                                        ),
                                        if (nombreArchivo != 'Laberinto2') ...[
                                          IconButton(
                                            onPressed: () {
                                              movementInstructionsCubit
                                                  .agregarIntruccion(
                                                      'recoger', 'recoger');
                                            },
                                            iconSize: 100,
                                            icon: Image.asset(
                                                'assets/buttons/Agarrar.png', // Reemplaza con la ruta de tu imagen en assets
                                                fit: BoxFit.cover,
                                                width: 60,
                                                height: 60),
                                          ),
                                          if (nombreArchivo.contains('5')) ...[
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'avanzar',
                                                  'avanzar',
                                                  'avanzar',
                                                  'avanzar',
                                                  'avanzar'
                                                ], 'Nivel 1');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 1.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                          ],
                                          if (nombreArchivo.contains('6')) ...[
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                ], 'Nivel 2');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 2.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                ], 'Nivel 2-X');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 2-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                          ],
                                          if (nombreArchivo.contains('7')) ...[
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeIzquierda'
                                                ], 'Nivel 3');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 3.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'avanzar',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'avanzar',
                                                  'avanzar'
                                                ], 'Nivel 3-X');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 3-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                          ],
                                          if (nombreArchivo.contains('8')) ...[
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'giroDeDerecha',
                                                  'giroDeDerecha',
                                                ], 'Nivel 4');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 4.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar'
                                                      'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar'
                                                ], 'Nivel 4-X');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 4-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                          ],
                                          if (nombreArchivo.contains('6') ||
                                              nombreArchivo.contains('7') ||
                                              nombreArchivo.contains('8')) ...[
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'avanzar',
                                                  'avanzar',
                                                  'avanzar',
                                                ], 'Nivel 2, 3 y 4');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 2, 3 y 4.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                          ],
                                          if (nombreArchivo.contains('7') ||
                                              nombreArchivo.contains('8')) ...[
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'avanzar',
                                                  'avanzar',
                                                ], 'Nivel 3 y 4');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 3 y 4.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                movementInstructionsCubit
                                                    .agregarIntruccion([
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                  'giroDeIzquierda',
                                                  'avanzar',
                                                  'giroDeDerecha',
                                                  'avanzar',
                                                ], 'Nivel 3 y 4-X');
                                              },
                                              iconSize: 100,
                                              icon: Image.asset(
                                                  'assets/buttons/Nivel 3 y 4-X.png', // Reemplaza con la ruta de tu imagen en assets
                                                  fit: BoxFit.cover,
                                                  height: 60),
                                            ),
                                          ]
                                        ]
                                      ]
                                    ],
                                  ),
                                ),

                                const RespuestaLaberinto(),

                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 30,
                                  ), // Puedes ajustar el valor según tus necesidades
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        child: PixelLargeBttn(
                                            path: "assets/buttons/Play.png",
                                            text: '',
                                            onPressed: () async {
                                              player.movementInstructions =
                                                  movementInstructionsCubit
                                                      .state
                                                      .expand((map) {
                                                if (map.key is List<String>) {
                                                  return map.key
                                                      as List<String>;
                                                } else {
                                                  return [map.key as String];
                                                }
                                              }).toList();
                                              List respuestaGeneral =
                                                  movementInstructionsCubit
                                                      .state
                                                      .map((e) => e.key)
                                                      .toList();

                                              int response = await player
                                                  .processMovementInstructionsResponse(
                                                      respuestaGeneral,
                                                      actividadLaberinto!
                                                          .mejorCamino!,
                                                      actividadLaberinto
                                                          .mejorCamino2);
                                              print(response);
                                              if (true) {
                                                Future.delayed(
                                                    Duration(seconds: 2), () {
                                                  // ignore: use_build_context_synchronously
                                                   _mostrarDialogoVictoria(
                                                            context,
                                                            router,
                                                            unidadesCubit,
                                                            actividadLaberinto!,
                                                            seguimientosCubit,
                                                            estudiantes,
                                                            curso.state.id!,
                                                            response);
                                                });
/*
                                                seguimientosCubit
                                                    .actualizarRespuestasActividadesEstudiantes(
                                                        estudiantes
                                                            .obtenerIds(),
                                                        '',
                                                        response,
                                                        actividadLaberinto.id!);
                                                        */
                                              }
                                            }),
                                      ),
                                      SizedBox(
                                        height: 60,
                                        child: PixelLargeBttn(
                                            path: "assets/buttons/Clean.png",
                                            text: '',
                                            onPressed: () async {
                                              movementInstructionsCubit
                                                  .limpiarInstrucciones();
                                            }),
                                      ),
                                      SizedBox(
                                          height: 50,
                                          child: PixelLargeBttn(
                                              path:
                                                  "assets/buttons/Reiniciar.png",
                                              text: '',
                                              onPressed: () {
                                                player.reiniciar();
                                                movementInstructionsCubit
                                                    .limpiarInstrucciones();
                                              }))
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

  actualizarCambiosSeguimientos(
      BuildContext context,
      GoRouter router,
      UnidadesCubit unidadesCubit,
      ActividadLaberinto actividadLaberinto,
      SeguimientosEstudiantesCubit seguimientosCubit,
      EstudiantesCubit estudiantes,
      int cursoId,
      int response) {
    // actualizar cubit para el estado en la plataforma
    seguimientosCubit.actualizarRespuestasActividadesEstudiantes(
        estudiantes.obtenerIds(), "", response, actividadLaberinto.id!);

    //guardar en la base de datos FB si es diferente del curso demo
    if (cursoId != 1) {
      cursoCs.actualizarRespuesta(cursoId, estudiantes.obtenerIds(),
          actividadLaberinto.id!, response, '');
    }
  }

  void _mostrarDialogoVictoria(
      BuildContext context,
      GoRouter router,
      UnidadesCubit unidadesCubit,
      ActividadLaberinto actividadLaberinto,
      SeguimientosEstudiantesCubit seguimientosCubit,
      EstudiantesCubit estudiantes,
      int cursoId,
      int response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('✨ ¡Tu respuesta ha sido guardada! ʕ•́ᴥ•̀ʔっ'),
          content: const Text(
              'Continua a la siguiente actividad o ¡Quedate e intenta la mejor respuesta posible!'),
          actions: <Widget>[
            PixelLargeBttn(
              path: "assets/items/ButtonOrange.png",
              text: 'Quedarme',
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            PixelLargeBttn(
              path: "assets/items/ButtonBlue.png",
              text: 'Siguiente',
              onPressed: () {
                actualizarCambiosSeguimientos(
                    context,
                    router,
                    unidadesCubit,
                    actividadLaberinto!,
                    seguimientosCubit,
                    estudiantes,
                    cursoId,
                    response);

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
                  } else if (siguienteActividadInfo.tipoActividad ==
                      "Desconectada") {
                    router.push(
                        '/desconectada/${siguienteActividadInfo.idActividad}');
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
