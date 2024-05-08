import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/actividad_desconectada.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_actividad.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/widgets/banner_info_actividades.dart';
import 'package:dev_tesis/ui/widgets/banner_instrucciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActividadDesconectadaScreen extends StatefulWidget {
  final int actividadId;
  const ActividadDesconectadaScreen({Key? key, required this.actividadId})
      : super(key: key);

  @override
  State<ActividadDesconectadaScreen> createState() =>
      _ActividadDesconectadaScreenState();
}

class _ActividadDesconectadaScreenState
    extends State<ActividadDesconectadaScreen> {
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final unidadesCubit = context.watch<UnidadesCubit>();

    final estudiantes = context.read<EstudiantesCubit>();
    List<String> avatares = [];
    for (var estudiante in estudiantes.state) {
      avatares.add(estudiante.avatar!);
    }

    final curso = context.read<CursoCubit>();
    ActividadDesconectada? actividadDesconectada;
    for (var unidad in curso.state.unidades!) {
      // Verifica si la unidad actual tiene la actividad a eliminar
      if (unidad.actividades != null) {
        // for que recorre las actividades

        for (Actividad actividad in unidad.actividades!) {
          if (actividad.id == widget.actividadId) {
            if (actividad is ActividadDesconectada) {
              actividadDesconectada = actividad;
            }
          }
        }
      }
    }

    String nombreUnidad =
        unidadesCubit.nombreUnidadDeActividad(actividadDesconectada!.id!);

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
      body: Container(
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
                          isDiagnostico:
                              actividadDesconectada.nombre == 'Diagnostico',
                          habilidades: actividadDesconectada.habilidades!,
                          titulo:
                              '$nombreUnidad \nActividad ${unidadesCubit.obtenerIndiceActividadEnUnidad(actividadDesconectada.id!)! + 1}',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: BannerInstruccionesActividad(
                            texto: actividadDesconectada.descripcion!,
                            rutaEjemplo:
                                'assets/items/ejemplosImg/${actividadDesconectada.ejemploImage}'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: null,
                                '${actividadDesconectada.ejercicioImage}',
                                fit: BoxFit.contain),
                            PixelLargeBttn(
                                path: "assets/items/ButtonBlue.png",
                                text: 'Siguiente',
                                onPressed: () {
                                  context
                                      .read<SeguimientosEstudiantesCubit>()
                                      .actualizarRespuestasActividadesEstudiantes(
                                          estudiantes.obtenerIds(),
                                          'Entregable',
                                          1,
                                          actividadDesconectada!.id!);
                                  _mostrarDialogoSiguienteActividad(
                                      context,
                                      router,
                                      unidadesCubit,
                                      actividadDesconectada);
                                }),
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
      ),
    );
  }

  void _mostrarDialogoSiguienteActividad(
    BuildContext context,
    GoRouter router,
    UnidadesCubit unidadesCubit,
    ActividadDesconectada actividadCuestionario,
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
                if (context
                    .read<UnidadesCubit>()
                    .esUltimaActividadGlobal(actividadCuestionario.id!)) {
                  router.push(
                      '/testautopercepcion/${context.read<CursoCubit>().state.id}');
                } else {
                  SiguienteActividadInfo siguienteActividadInfo = unidadesCubit
                      .siguienteActividadInfo(actividadCuestionario.id!);
                  if (siguienteActividadInfo.tipoActividad == "Laberinto") {
                    router.push(
                        '/laberinto/${siguienteActividadInfo.idActividad}');
                  } else if (siguienteActividadInfo.tipoActividad ==
                      "Cuestionario") {
                    print('Siguiente Actividad Cuestionario');
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
