import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/domain/model/casilla.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/ui/bloc/actividad_custio_test.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/banner_info_actividades.dart';
import 'package:dev_tesis/ui/widgets/banner_instrucciones.dart';
import 'package:dev_tesis/ui/widgets/radio_respuestas_cuestionario.dart';
import 'package:dev_tesis/ui/widgets/response_game_flame.dart';
import 'package:dev_tesis/ui/widgets/tablero_cuestionario.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActividadCuestionarioScreen extends StatefulWidget {
  final String actividadId;

  const ActividadCuestionarioScreen({Key? key, required this.actividadId})
      : super(key: key);

  @override
  State<ActividadCuestionarioScreen> createState() =>
      _ActividadCuestionarioScreenState();
}

class _ActividadCuestionarioScreenState
    extends State<ActividadCuestionarioScreen> {
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final unidadesCubit = context.watch<UnidadesCubit>();

    final curso = context.read<CursoCubit>();
    int selectedOptionIndex =2;
    List<ActividadCuestionario> actividadesCuestionario =
        context.watch<ActividadCuestionarioCubit>().state;
    for (var unidad in curso.state.unidades!) {
      // Verifica si la unidad actual tiene la actividad a eliminar
      if (unidad.actividades != null) {
        // for que recorre las actividades

        for (Actividad actividad in unidad.actividades!) {
          if (actividad.id == widget.actividadId) {
            if (actividad is ActividadCuestionario) {
              actividadesCuestionario.add(actividad);
            }
          }
        }
      }
    }

    //buscar actividad por id dentro del curso
    ActividadCuestionario actividadCuestionario = actividadesCuestionario
        .firstWhere((actividad) => actividad.id == widget.actividadId);

    return Scaffold(
      appBar: const CustomAppBar(userName: 'usuario'),
      // Responsive UI design for desktop and mobile
      body: MediaQuery.of(context).size.width > 700
          ? Container(
              color: blueColor,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const IntrinsicHeight(
                              child: BannerInfoActividades(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: BannerInstruccionesActividad(
                                  texto:
                                      'Ayuda a Juan a encontrar el camino al saco de café que ha recolectado',
                                  rutaEjemplo:
                                      'assets/items/ejemplosImg/ejemplocuestionario.png'),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Add content for the left section of the blue board
                                        TableroCuestionario(
                                            actividadCuestionario:
                                                actividadCuestionario),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, bottom: 20),
                                          child: const Text(
                                            "Selecciona la mejor respuesta para llegar a la meta:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: RadioRespuestasCuestionario(
                                              imagesList: actividadCuestionario
                                                  .respuestas!,
                                              radioRespuesta: (respuesta) {
                                                setState(() {
                                                  selectedOptionIndex =
                                                      2;
                                                });
                                              }),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, bottom: 20),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                PixelLargeBttn(
                                                    path:
                                                        "assets/items/ButtonBlue.png",
                                                    text: 'Siguiente',
                                                    onPressed: () {

                                                      selectedOptionIndex == -1 ? showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Tu Respuesta No ha sido guardada'),
                                                            content:
                                                                const SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Por favor responde para poder continuar con la siguiente Actividad'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              PixelLargeBttn(
                                                                  path:
                                                                      "assets/items/ButtonBlue.png",
                                                                  text:
                                                                      'Volver',
                                                                  onPressed:
                                                                      () {
                                                                        
                                                                        Navigator.of(context).pop();
                                                                      })
                                                            ],
                                                          );
                                                        },
                                                      )
                                                       :
                                                      _mostrarDialogoSiguienteActividad( context,
                                                      router,
                                                      unidadesCubit,
                                                      actividadCuestionario);
                                                    })
                                              ]),
                                        )
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
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: blueColor,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
    );
  }

  void _mostrarDialogoSiguienteActividad(BuildContext context, GoRouter router,
      UnidadesCubit unidadesCubit, ActividadCuestionario actividadLaberinto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tu Respuesta ha sido guardada'),
          content: const Text('Continuemos con la siguiente Actividad!'),
          actions: <Widget>[
            PixelLargeBttn(
              path: "assets/items/ButtonOrange.png",
              text: 'Volver',
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
                if (siguienteActividadInfo
                        .tipoActividad ==
                    "Laberinto") {
                  router.go(
                      '/laberinto/${siguienteActividadInfo.idActividad}');
                } else if (siguienteActividadInfo.tipoActividad == "Cuestionario") {
                  router.go(
                      '/cuestionario/${siguienteActividadInfo.idActividad}');
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
