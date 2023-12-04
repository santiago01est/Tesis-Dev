import 'dart:convert';

import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor.dart';
import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PanelProfesorCursoScreen extends StatefulWidget {
  final String cursoId;
  const PanelProfesorCursoScreen({super.key, required this.cursoId});

  @override
  State<PanelProfesorCursoScreen> createState() =>
      _PanelProfesorCursoScreenState();
}

//al iniciar la pantalla se obtienen los datos del curso

class _PanelProfesorCursoScreenState extends State<PanelProfesorCursoScreen> {
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();
  final UnidadCasoUso unidadCasoUso = getIt<UnidadCasoUso>();

  @override
  void initState() {
    super.initState();
    // si el cubit no tiene datos, los obtiene
    _fetchCurso();
  }

  void _fetchCurso() async {
    /* forma local */
    try {
      if (context.read<BDCursosCubit>().state.isEmpty) {
        final cursos = await cursosCasoUso.getCursos();
        context.read<BDCursosCubit>().subirCursos(cursos);
        // buscar en cursos el curso con el id correspondiente
        final curso = cursos.firstWhere((c) => c.id == widget.cursoId);
        context.read<CursoCubit>().actualizarCurso(curso);
      } else {
        final cursos = context.read<BDCursosCubit>().state;
        // buscar en cursos el curso con el id correspondiente
        final curso = cursos.firstWhere((c) => c.id == widget.cursoId);
        context.read<CursoCubit>().actualizarCurso(curso);
      }
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final cursoCubit = context.watch<CursoCubit>();
    return Scaffold(
        backgroundColor: blueColor,
        appBar: const AppBarProfesor(),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/FondoNevado.png'), // Ruta de tu imagen de fondo
                  fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                ),
              ),
              child: Column(
                children: [
                  // Contenido superpuesto en la primera sección
                  // Fila con botón en la parte superior derecha
                  const SizedBox(height: 20.0),
                  Center(
                      child: TitleText(
                    text: cursoCubit.state.nombre!,
                  )),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Verifica el ancho de la pantalla
                      if (constraints.maxWidth > 700) {
                        // Pantalla grande: utiliza una fila
                        return FractionallySizedBox(
                            widthFactor: 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cardInfoCurso(
                                  cursoCubit.state.nombre!,
                                  cursoCubit.state.colegio!,
                                  cursoCubit.state.ciudad!,
                                  cursoCubit.state.departamento!,
                                  cursoCubit.state.fechaCreacion!,
                                  cursoCubit.state.unidades!.length,
                                  unidadCasoUso
                                      .numeroTotalActividades(cursoCubit.state),
                                  cursoCubit.state.estado!,
                                ),
                                buildCardWithImageAndGraph(
                                    cursoCubit.state.descripcion!)
                              ],
                            ));
                      } else {
                        // retorna para Pantalla pequeña: utiliza una columna
                        return Column(
                          children: [
                            Container(
                              width: 600,
                              padding: const EdgeInsets.all(16),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: blueColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16), // Ajusta el padding del contenido
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SubtitleText(
                                                  text:
                                                      'Información general del curso',
                                                ),
                                                const SizedBox(height: 10),
                                                ParagraphText(
                                                  text:
                                                      "${cursoCubit.state.nombre!} del Colegio ${cursoCubit.state.colegio!} de ${cursoCubit.state.ciudad!}, ${cursoCubit.state.departamento!}.",
                                                ),
                                              ]),
                                        ),
                                      ]),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ParagraphText(
                                                  text:
                                                      'Número de Unidades: ${cursoCubit.state.unidades!}',
                                                ),
                                                ParagraphText(
                                                  text:
                                                      'Número de Actividades: ${unidadCasoUso.numeroTotalActividades(cursoCubit.state)}',
                                                ),
                                                ParagraphText(
                                                  text:
                                                      'Fecha Creación: ${cursoCubit.state.fechaCreacion!}',
                                                ),
                                                ParagraphText(
                                                  text: cursoCubit.state.estado!
                                                      ? 'Estado: Activo'
                                                      : 'Estado: Inactivo',
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Image.asset(
                                              'assets/items/perico_mascota.png',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: blueColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      SubtitleText(
                                        text: 'Descripción del curso',
                                      ),
                                      const SizedBox(height: 10),
                                      ParagraphText(
                                        text: cursoCubit.state.descripcion!,
                                      ),
                                      // Agrega cualquier contenido adicional que desees aquí
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            const DefaultTabController(
              length: 2, // Número de pestañas
              child: Column(
                children: [
                  // TabBar
                  TabBar(
                    tabs: [
                      Tab(text: 'Contenido'),
                      Tab(text: 'Estudiantes'),
                    ],
                  ),
                  // TabBarView
                  SizedBox(
                    height: 200, // Ajusta la altura según tus necesidades
                    child: TabBarView(
                      children: [
                        // Contenido de la primera pestaña
                        Center(
                          child: Text('Contenido de la Pestaña 1'),
                        ),
                        // Contenido de la segunda pestaña
                        Center(
                          child: Text('Contenido de la Pestaña 2'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget cardInfoCurso(String nombreCurso, String colegio, String ciudad,
      String depto, String fecha, int unidades, int actividades, bool estado) {
    return Expanded(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: blueColor,
          child: Padding(
            padding:
                const EdgeInsets.all(16), // Ajusta el padding del contenido
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubtitleText(
                            text: 'Información general del curso',
                          ),
                          const SizedBox(height: 10),
                          ParagraphText(
                            text:
                                "$nombreCurso del Colegio $colegio de $ciudad, $depto.",
                          ),
                        ]),
                  ),
                ]),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ParagraphText(
                            text: 'Número de Unidades: $unidades',
                          ),
                          ParagraphText(
                            text: 'Número de Actividades: $actividades',
                          ),
                          ParagraphText(
                            text: 'Fecha Creación: $fecha',
                          ),
                          ParagraphText(
                            text:
                                estado ? 'Estado: Activo' : 'Estado: Inactivo',
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/items/perico_mascota.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardWithImageAndGraph(String descripcion) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: blueColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SubtitleText(
                  text: 'Descripción del curso',
                ),
                const SizedBox(height: 10),
                ParagraphText(
                  text: descripcion,
                ),
                // Agrega cualquier contenido adicional que desees aquí
              ],
            ),
          ),
        ),
      ),
    );
  }
}
