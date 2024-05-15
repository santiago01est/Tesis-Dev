import 'package:dev_tesis/constants/styles.dart';
import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:dev_tesis/domain/casos_uso/profesor_casos_uso/profesor_cs.dart';
import 'package:dev_tesis/domain/casos_uso/util_cs.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/main.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:dev_tesis/ui/bloc/estudiante_bloc.dart';
import 'package:dev_tesis/ui/bloc/profesor_bloc.dart';
import 'package:dev_tesis/ui/bloc/rol_bloc.dart';
import 'package:dev_tesis/ui/components/cards/curso_cards.dart';
import 'package:dev_tesis/ui/components/textos/textos.dart';
import 'package:dev_tesis/ui/widgets/PopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LayoutMisCursos extends StatefulWidget {
  final int profesorId;

  const LayoutMisCursos({Key? key, required this.profesorId}) : super(key: key);

  @override
  State<LayoutMisCursos> createState() => _LayoutMisCursosState();
}

class _LayoutMisCursosState extends State<LayoutMisCursos> {
  late InitData _cursosProfesoresCasoUso;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    //obtener solo los cursos del profesor
    List<Curso>  cursosCubit = context.read<BDCursosCubit>().state;
    final rolCubit = context.read<RolCubit>();
    final profesorCubit = context.read<ProfesorCubit>();

    List<Curso> misCursos = [];

    for (int i = 0; i < cursosCubit.length; i++) {
      if (cursosCubit[i].profesor == widget.profesorId) {
        misCursos.add(cursosCubit[i]);
      }
    }

  

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
                  return Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8.0, // Espacio entre las imágenes
                    runSpacing: 8.0,
                    children: List.generate(
                      misCursos.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            if (rolCubit.state == 'profesor') {
                              router.go('/panelcurso/${misCursos[index].id}');
                            } else {
                              if (context
                                  .read<EstudiantesCubit>()
                                  .state
                                  .isEmpty) {
                                PopupUtils.showCodeAccessPopup(
                                    context, misCursos[index]);
                              } else {
                                router
                                    .push('/panelcurso/${misCursos[index].id}');
                              }
                            }
                          },
                          child: CursoCard(
                            curso: misCursos[index],
                            nombreProfesor: profesorCubit.state.nombre!,
                          ),
                        );
                      },
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
