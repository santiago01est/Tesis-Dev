import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/common_cs.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:dev_tesis/ui/bloc/unidades_bloc.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LayoutUnidadCurso extends StatefulWidget {
  final int idProfesor;
  const LayoutUnidadCurso({Key? key, required this.idProfesor})
      : super(key: key);

  @override
  State<LayoutUnidadCurso> createState() => _LayoutUnidadCursoState();
}

class _LayoutUnidadCursoState extends State<LayoutUnidadCurso> {
  Color getBackgroundColor(int actividadId, Seguimiento seguimientoState) {
    Respuesta miRespuesta = seguimientoState.respuestasActividades!
        .firstWhere((element) => element.actividadId == actividadId);
    int peso = miRespuesta.peso!;

    // Verificar si hay un cero en la lista en el índice de la actividad
    if (peso == 0 || peso == -1) {
      // Si hay un cero, devolver gris
      return Color.fromARGB(255, 245, 245, 245);
    } else {
      // Si no hay un cero, devolver verde
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonCs cursosProfesoresCasoUso = CommonCs(
      cursosCasoUso: getIt<CursosCasoUso>(),
      profesorCasoUso: getIt<ProfesorCasoUso>(),
      context: context,
    );

    final unidades = context.watch<UnidadesCubit>();
    final curso = context.watch<CursoCubit>();
    final seguimientosCubit = context.watch<SeguimientosEstudiantesCubit>();
    final rolCubit = context.read<RolCubit>();
    final router = GoRouter.of(context);

    int userID;
    if (rolCubit.state == 'estudiante') {
      userID = context.watch<EstudiantesCubit>().state.first.id!;
    } else {
      userID = widget.idProfesor;
    }

    void eliminarActividad(int idActividad) {
      // Elimina la actividad del listado de actividades de la unidad

      unidades.eliminarActividadDeUnidad(idActividad);
      curso.eliminarActividadDeUnidadDelCurso(idActividad, context);
      seguimientosCubit.eliminarActividadDeUnidadDelCurso(idActividad);

      cursosProfesoresCasoUso.eliminarActividad(idActividad);

      // Notifica a Flutter que los datos han cambiado y la interfaz de usuario necesita actualizarse
      setState(() {});
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        // Mostrar la lista de unidades
        Expanded(
            child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 50),
            Padding(
                padding: EdgeInsets.all(0),
                child: Center(
                    child: FractionallySizedBox(
                        // si el ancho de la pantalla es menor a 700 es un dispositivo movil
                        widthFactor:
                            MediaQuery.of(context).size.width < 700 ? 0.8 : 0.6,
                        child: BlocBuilder<SeguimientosEstudiantesCubit,
                                List<Seguimiento>>(
                            builder: (context, seguimientoState) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: unidades.state.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: index == 1 ? orangeColor : blueColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      // Primera fila
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Mini card con índice
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: EdgeInsets.all(20),
                                            child: TitleText(
                                              text:
                                                  unidades.state[index].nombre!,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          // Imagen de la mascota
                                          Image.asset(
                                            //si el indice es uno se muestra una imagen si es diferente otra
                                            index == 1
                                                ? 'assets/avatares/perico_avatar.png'
                                                : 'assets/avatares/chiguiro_avatar.png',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      // Segunda fila con lista de actividades
                                      Wrap(
                                        spacing:
                                            8.0, // Espacio horizontal entre los elementos
                                        runSpacing:
                                            8.0, // Espacio vertical entre las filas de elementos
                                        children: List.generate(
                                          unidades
                                              .state[index].actividades!.length,
                                          (activityIndex) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Card(
                                                    elevation: 2,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    color: getBackgroundColor(
                                                      unidades
                                                          .state[index]
                                                          .actividades![
                                                              activityIndex]
                                                          .id!,
                                                      seguimientosCubit
                                                          .obtenerSeguimientoEstudiante(
                                                              userID),
                                                    ),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (unidades
                                                                .state[index]
                                                                .actividades![
                                                                    activityIndex]
                                                                .tipoActividad ==
                                                            "Laberinto") {
                                                          router.push(
                                                              '/laberinto/${unidades.state[index].actividades![activityIndex].id}');
                                                        } else if (unidades
                                                                .state[index]
                                                                .actividades![
                                                                    activityIndex]
                                                                .tipoActividad ==
                                                            "Cuestionario") {
                                                          router.push(
                                                              '/cuestionario/${unidades.state[index].actividades![activityIndex].id}');
                                                        } else if (unidades
                                                                .state[index]
                                                                .actividades![
                                                                    activityIndex]
                                                                .tipoActividad ==
                                                            "Desconectada") {
                                                          router.push(
                                                              '/desconectada/${unidades.state[index].actividades![activityIndex].id}');
                                                        }
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          '${activityIndex + 1}',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                rolCubit.state == 'profesor' &&
                                                        index != 0
                                                    ? IconButton(
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    "¿Estás seguro de eliminar esta actividad permanentemente?"),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/avatares/perico_avatar.png',
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          300,
                                                                    ), // Reemplaza 'ruta_de_la_imagen' con la ruta real de tu imagen
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        "Cancelar"),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      int idActividad = unidades
                                                                          .state[
                                                                              index]
                                                                          .actividades![
                                                                              activityIndex]
                                                                          .id!;

                                                                      unidades.eliminarActividadDeUnidad(
                                                                          idActividad);
                                                                      curso.eliminarActividadDeUnidadDelCurso(
                                                                          idActividad,
                                                                          context);
                                                                      seguimientosCubit
                                                                          .eliminarActividadDeUnidadDelCurso(
                                                                              idActividad);
                                                                      /*
                                                                      cursosProfesoresCasoUso
                                                                          .eliminarActividad(
                                                                              idActividad);
*/
                                                                      // Notifica a Flutter que los datos han cambiado y la interfaz de usuario necesita actualizarse
                                                                      setState(
                                                                          () {});

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        "Eliminar"),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                          // Aquí puedes agregar la lógica para eliminar la actividad
                                                        },
                                                      )
                                                    : Container()
                                              ],
                                            );
                                          },
                                        ),
                                      ),

                                      //Boton
                                      SizedBox(height: 10),
                                      rolCubit.state == 'profesor' && index != 0
                                          ? PixelLargeBttn(
                                              path:
                                                  'assets/items/ButtonBlue.png',
                                              onPressed: () {
                                                router.push(
                                                    '/estudiocuestionario/${unidades.state[index].id}');
                                              },
                                              text: 'Crear Actividad')
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }))))
          ]),
        ))
      ],
    );
  }
}


/*
 
*/