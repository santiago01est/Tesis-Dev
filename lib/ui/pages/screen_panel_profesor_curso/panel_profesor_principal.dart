import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/components/appbar/appbar_profesor_panel.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/layout_mis_cursos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanelPrincipalProfesorScreen extends StatefulWidget {
  final int profesorId;
  const PanelPrincipalProfesorScreen({super.key, required this.profesorId});

  @override
  State<PanelPrincipalProfesorScreen> createState() =>
      _PanelPrincipalProfesorScreenState();
}

class _PanelPrincipalProfesorScreenState
    extends State<PanelPrincipalProfesorScreen> {
  final ProfesorCasoUso profesorCasoUso = getIt<ProfesorCasoUso>();
  final CursosCasoUso cursosCasoUso = getIt<CursosCasoUso>();

  @override
  void initState() {
    super.initState();
    // si el cubit no tiene datos, los obtiene
    _fetchProfesor();
    _fetchCurso();
  }

  void _fetchProfesor() async {
    /* forma local */
    try {
      if (context.read<ProfesoresCubit>().state.isEmpty) {
        final profesores = await profesorCasoUso.getProfesores();
        // ignore: use_build_context_synchronously
        context.read<ProfesoresCubit>().subirProfesores(profesores);
        // buscar en cursos el curso con el id correspondiente
        final profesor =
            profesores.firstWhere((c) => c.id == widget.profesorId);
        // ignore: use_build_context_synchronously
        context.read<ProfesorCubit>().actualizarProfesor(profesor);
      } else {
        final profesores = context.read<ProfesoresCubit>().state;
        // buscar en cursos el curso con el id correspondiente
        final profesor =
            profesores.firstWhere((c) => c.id == widget.profesorId);
        context.read<ProfesorCubit>().actualizarProfesor(profesor);
      }
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  void _fetchCurso() async {
    /* forma local */
    try {
      if (context.read<BDCursosCubit>().state.isEmpty) {
        final cursos = await cursosCasoUso.getCursos();
        context.read<BDCursosCubit>().subirCursos(cursos);
      }
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje de error
      print('Error al obtener cursos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final profesorCubit = context.watch<ProfesorCubit>();

    return Scaffold(
      appBar: AppBarProfesorPanel(
        profesorId: widget.profesorId,
      ),
      backgroundColor: blueColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/fondos/FondoHome.png'), // Ruta de tu imagen de fondo
                  fit: BoxFit.cover, // Ajuste para cubrir el contenedor
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    // verifica el ancho de la pantalla
                    height: MediaQuery.of(context).size.width < 700 ? 50 : 300,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    // Verifica el ancho de la pantalla
                    if (constraints.maxWidth > 700) {
                      // Pantalla grande: utiliza una fila
                      return FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              cardImgPerfil(profesorCubit.state.avatar!),
                              cardInfoProfesor(profesorCubit.state.nombre!,
                                  profesorCubit.state.bio!),
                            ],
                          ));
                    } else {
                      // retorna para Pantalla pequeña: utiliza una columna
                      return Column(
                        children: [
                          cardImgPerfil(profesorCubit.state.avatar!),
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
                                      text: profesorCubit.state.nombre!,
                                    ),
                                    const SizedBox(height: 10),
                                    ParagraphText(
                                      text: profesorCubit.state.bio!,
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
                  }),
                ],
              ),
            ),
            // Segunda sección con fondo azul
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: LayoutMisCursos(
                      profesorId: widget.profesorId,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardImgPerfil(String pathImg) {
    // retorna una card azul con los bordes superiores redondos
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: blueColor,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              //imagen
              Image.asset(
                pathImg,
                width: 150,
                height: 150,
              )
            ])));
  }

  Widget cardInfoProfesor(String nombre, String bio) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(0),
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
                  text: nombre,
                ),
                const SizedBox(height: 10),
                ParagraphText(
                  text: bio,
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
