import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/respuesta.dart';
import 'package:dev_tesis/domain/model/seguimiento.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';
import 'package:dev_tesis/ui/bloc/seguimiento_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;
  final BuildContext context;

  CursosCasoUso({required this.cursoRepository, required this.context});

  Future<List<Curso>> getCursos() async {
    return await cursoRepository.getCursos();
  }

  void guardarCurso(Curso curso) {
    cursoRepository.guardarCurso(curso);
  }

  //obtener curso por su id
  Future<Curso> getCursoById(String id) {
    return cursoRepository.getCursoById(id);
  }

  // crear Seguimientos del curso
  void crearSeguimientos(List<Estudiante> estudiantes, int idProfesor,
      int idCurso, List<Actividad> actividades) {
    /*
    Recorre la lista de estudiantes y crea un seguimiento para cada uno de ellos
    */
    List<Seguimiento> seguimientos = [];
    for (int i = 0; i < estudiantes.length; i++) {
      seguimientos.add(
        Seguimiento(
            id: i,
            respuestasActividades: List.generate(
                actividades.length,
                (index) => Respuesta(
                    id: i,
                    respuestaUsuario: '',
                    peso: -1,
                    actividadId: actividades[index].id!,
                    seguimientoId: i)),
            test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            calificacion: 0,
            userId: estudiantes[i].id,
            cursoId: idCurso),
      );
    }

    seguimientos.add(Seguimiento(
        id: seguimientos.length + 1,
        respuestasActividades: List.generate(
            actividades.length,
            (index) => Respuesta(
                id: 1,
                respuestaUsuario: '',
                peso: -1,
                actividadId: actividades[index].id!,
                seguimientoId: seguimientos.length + 1)),
        test: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        calificacion: 0,
        userId: idProfesor,
        cursoId: idCurso));

    cursoRepository.crearSeguimientos(seguimientos);
    // Copia en Cubit
    context
        .read<SeguimientosEstudiantesCubit>()
        .subirSeguimientos(seguimientos);
  }

  //Metodo que agrega una actividad en el seguimiento del grupo
  void agregarActividad(int idCurso, Actividad actividad) {
    context
        .read<SeguimientosEstudiantesCubit>()
        .agregarRespuesta(idCurso, actividad);
  }
}
