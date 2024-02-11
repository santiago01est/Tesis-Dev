import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/unidad_casos_uso/unidad_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/curso_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor_panel.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/layout_curso_unidades.dart';
import 'package:dev_tesis/ui/widgets/lista_estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PanelCursoScreen extends StatefulWidget {
  final String cursoId;
  const PanelCursoScreen({super.key, required this.cursoId});

  @override
  State<PanelCursoScreen> createState() => _PanelCursoScreenState();
}

//al iniciar la pantalla se obtienen los datos del curso

class _PanelCursoScreenState extends State<PanelCursoScreen> {
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
    final cursoCubit = context.watch<CursoCubit>();
    final router = GoRouter.of(context);
    final profesoresCubit = context.watch<ProfesoresCubit>();
    String? nombreProfesor = profesoresCubit.state
        .firstWhere((profesor) => profesor.id == cursoCubit.state.profesor)
        .nombre;

    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        backgroundColor: thirtyColor,
        appBar: AppBarProfesorPanel(profesorId: cursoCubit.state.profesor!),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Encabezado (header)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      cursoCubit.state.portada!,
                    ),
                    fit: BoxFit.cover,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  cardInfoCurso(
                                    cursoCubit.state.nombre!,
                                    cursoCubit.state.colegio!,
                                    cursoCubit.state.ciudad!,
                                    cursoCubit.state.departamento!,
                                    cursoCubit.state.fechaCreacion!,
                                    cursoCubit.state.unidades!.length,
                                    unidadCasoUso.numeroTotalActividades(
                                        cursoCubit.state),
                                    cursoCubit.state.estado!,
                                    nombreProfesor!,
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
                                                        'Profesor: $nombreProfesor!',
                                                  ),
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
                                                    text: cursoCubit
                                                            .state.estado!
                                                        ? 'Estado: Activo'
                                                        : 'Estado: Inactivo',
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Image.asset(
                                                'assets/avatares/perico_avatar.png',
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

              // Añadimos el TabBar
              const TabBar(
                tabs: [
                  Tab(text: 'Contenido'),
                  Tab(text: 'Estudiantes'),
                ],
              ),

              // Añadimos el TabBarView
              SizedBox(
                height: MediaQuery.of(context)
                    .size
                    .height, // Ajusta la altura según tus necesidades
                child: TabBarView(
                  children: [
                    // Contenido de la primera pestaña
                    // Utiliza tu LayoutUnidadCurso o el contenido que desees
                    LayoutUnidadCurso(
                      unidades: cursoCubit.state.unidades!,
                    ),
                    ListaEstudiantesWidget()
                    // Contenido de la segunda pestaña
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardInfoCurso(
      String nombreCurso,
      String colegio,
      String ciudad,
      String depto,
      String fecha,
      int unidades,
      int actividades,
      bool estado,
      String profesor) {
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
                            text: 'Profesor: $profesor',
                          ),
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
                        'assets/avatares/perico_avatar.png',
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
