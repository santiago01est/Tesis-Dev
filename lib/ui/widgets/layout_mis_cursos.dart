import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LayoutMisCursos extends StatelessWidget {
  final int profesorId;

  const LayoutMisCursos({Key? key, required this.profesorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final BDCursosCubit bdCursosCubit = context.watch<BDCursosCubit>();
    //obtener solo los cursos del profesor
    final cursos = bdCursosCubit.state;

    List<Curso> misCursos = bdCursosCubit.state.where(
      (curso) => curso.profesor == profesorId).toList();

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 50),
        Padding(
            padding: EdgeInsets.all(0),
            child: Center(
                child: FractionallySizedBox(
              // si el ancho de la pantalla es menor a 700 es un dispositivo movil
              widthFactor: MediaQuery.of(context).size.width < 700 ? 0.8 : 0.6,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: misCursos.length,
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
                          LayoutBuilder(builder: (context, constraints) {
                            // Verifica el ancho de la pantalla
                            if (constraints.maxWidth > 700) {
                              // Pantalla grande: utiliza una fila
                              return GestureDetector(
                                onTap: () {
                                  router.go(
                                      '/panelprofesorcurso/${misCursos[index].id}');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // dos columnas
                                    Expanded(
                                        child: Column(children: [
                                      SubtitleText(
                                          text: misCursos[index].nombre!),
                                      SubtitleText(
                                          text: misCursos[index].descripcion!),
                                    ])),
                                    /* Expanded(
                                        child: Column(children: [
                                      SubtitleText(
                                          text: misCursos[index].descripcion!),
                                    ])) */
                                  ],
                                ),
                              );
                            } else {
                              // retorna para Pantalla pequeña: utiliza una columna
                              return Column(
                                children: [
                                  // dos columnas
                                  Expanded(
                                      child: Column(children: [
                                    SubtitleText(
                                        text: misCursos[index].nombre!),
                                    SubtitleText(
                                        text: misCursos[index].descripcion!),
                                  ])),
                                  Expanded(
                                      child: Column(children: [
                                    SubtitleText(
                                        text: misCursos[index].descripcion!),
                                  ]))
                                ],
                              );
                            }
                          }),

                          // Segunda fila con lista de actividades
                        ],
                      ),
                    ),
                  );
                },
              ),
            )))
      ]),
    );
  }

  List<Curso> obtenerMisCursos(int profesorId, List<Curso> cursos) {
    //for que retorna los cursos por el id del profesor
    List<Curso> misCursos = [];
    for (var i = 0; i < cursos.length; i++) {
      if (cursos[i].profesor == profesorId) {
        misCursos.add(cursos[i]);
      }
    }

    return misCursos;
  }
}
