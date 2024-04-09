import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_cuestionario.dart';
import 'package:dev_tesis/domain/model/actividad_laberinto.dart';
import 'package:dev_tesis/domain/model/casilla.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/game/player/player.dart';
import 'package:dev_tesis/game/game_activity.dart';
import 'package:dev_tesis/ui/bloc/actividad_custio_test.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/game/instrucciones_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_estudiantes.dart';
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
  int _selectedOptionIndex = -1;
  bool _mostrarPista = true;
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final unidadesCubit = context.watch<UnidadesCubit>();
    final seguimientosCubit = context.watch<SeguimientosEstudiantesCubit>();

    final estudiantes = context.read<EstudiantesCubit>();
    List<String> avatares = [];
    for (var estudiante in estudiantes.state) {
      avatares.add(estudiante.avatar!);
    }

    final curso = context.read<CursoCubit>();

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

    String nombreUnidad =
        unidadesCubit.nombreUnidadDeActividad(actividadCuestionario.id!);

    // Verificar si la actividad tiene una pista
    if (actividadCuestionario.pista != null &&
        actividadCuestionario.pista!.isNotEmpty &&
        _mostrarPista) {
      _mostrarPista = false;
      // Mostrar el diálogo después de que se haya construido la pantalla
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Mostrar el diálogo después de que se haya construido la pantalla
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Información '),
              content:
                  Image.asset(actividadCuestionario.pista!, fit: BoxFit.cover),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      });
    }
    return Scaffold(
      appBar: CustomNavigationBar(
        platformName: 'MiPlataforma',
        userName: 'Usuario1',
        userAvatars: avatares,
        onLogout: () {
          // Aquí implementa la lógica para cerrar sesión
          print('Cerrar sesión');
        },
      ),
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
                            IntrinsicHeight(
                              child: BannerInfoActividades(
                                titulo:
                                    '$nombreUnidad \n${actividadCuestionario.nombre!}',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              child: BannerInstruccionesActividad(
                                  texto: actividadCuestionario.descripcion!,
                                  rutaEjemplo:
                                      'assets/items/ejemplosImg/${actividadCuestionario.ejemploImage}'),
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
                                        actividadCuestionario.ejercicioImage ==
                                                ''
                                            ? TableroCuestionario(
                                                actividadCuestionario:
                                                    actividadCuestionario)
                                            : SizedBox(
                                                width:
                                                    500, // Tamaño del tablero (6 casillas * 90px por casilla)
                                                height:
                                                    500, // Tamaño del tablero (6 casillas * 90px por casilla)
                                                child: Image.asset(
                                                    '${actividadCuestionario.ejercicioImage}',
                                                    fit: BoxFit.contain))
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
                                        RadioRespuestasCuestionario(
                                            imagesList: actividadCuestionario
                                                .respuestas!,
                                            radioRespuesta: (int respuesta) {
                                              setState(() {
                                                _selectedOptionIndex =
                                                    respuesta + 1;
                                                
                                                // identifica el actual estudiante y actualiza su respectivo seguimiento

                                                //seguimiento.respuestasActividades![unidadesCubit.indiceActividadPorId(actividadCuestionario.id!)!]=_selectedOptionIndex;
                                                //seguimientoCubit.actualizarSeguimiento(seguimiento);
                                                seguimientosCubit
                                                    .actualizarRespuestasActividadesEstudiantes(
                                                        estudiantes
                                                            .obtenerIds(),
                                                        _selectedOptionIndex,
                                                        unidadesCubit
                                                            .indiceActividadPorId(
                                                                actividadCuestionario
                                                                    .id!)!);
                                              });
                                            },
                                            initialValue: -1),
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
                                                      _selectedOptionIndex == -1
                                                          ? showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Tu Respuesta No ha sido guardada'),
                                                                  content:
                                                                      const SingleChildScrollView(
                                                                    child:
                                                                        Column(
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
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        })
                                                                  ],
                                                                );
                                                              },
                                                            )
                                                          : _mostrarDialogoSiguienteActividad(
                                                              context,
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
      floatingActionButton: actividadCuestionario.pista != null &&
              actividadCuestionario.pista!.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // Acción al hacer clic en el botón flotante
                // Aquí puedes mostrar el showDialog de la pista
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Información '),
                      content: Image.asset(actividadCuestionario.pista!,
                          fit: BoxFit.cover),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.lightbulb),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _mostrarDialogoSiguienteActividad(
    BuildContext context,
    GoRouter router,
    UnidadesCubit unidadesCubit,
    ActividadCuestionario actividadCuestionario,
  ) {
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
                if (actividadCuestionario.id! == '15') {
                  router.push('/seguimientoprofesor');
                } else {
                  SiguienteActividadInfo siguienteActividadInfo = unidadesCubit
                      .siguienteActividadInfo(actividadCuestionario.id!);
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
