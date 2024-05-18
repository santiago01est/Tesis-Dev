import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/ui/bloc/bd_cursos.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class CursoCubit extends Cubit<Curso> {
  CursoCubit() : super(Curso());

  // Método para cambiar el nombre
  void actualizarCurso(Curso curso) {
    emit(curso);
  }

  void limpiarCubit() {
    emit(Curso());
  }

  void actualizarCursoAtributos(int cursoId, String nombre, String descripcion){
    // crea una copia del curso
    final estadoActual = state;
    final nuevoCurso = estadoActual.copyWith(
      nombre: nombre,
      descripcion: descripcion
    );
    emit(nuevoCurso);
  }

  // Método para buscar un estudiante por nombre
  Estudiante? buscarEstudiantePorNombre(String nombreEstudiante) {
    // Obtenemos el estado actual del curso
    final estadoActual = state;

    // Verificamos si el curso tiene una lista de estudiantes
    if (estadoActual.estudiantes != null) {
      // Buscamos el estudiante por su nombre dentro de la lista de estudiantes
      return estadoActual.estudiantes!.firstWhere(
        (estudiante) => estudiante.nombre == nombreEstudiante,
      );
    }

    // Si no hay lista de estudiantes o no se encuentra el estudiante, devolvemos null
    return null;
  }

  void addActividad(Actividad actividad, int idUnidad, BuildContext context) {
    List<Unidad> nuevasUnidades = [];
    for (var unidad in state.unidades!) {
      if (unidad.id == idUnidad) {
        unidad.actividades!.add(actividad);
      }
      nuevasUnidades.add(unidad);
    }
    Curso curso=state;
    curso.unidades=nuevasUnidades;
   //emit(curso);

   context.read<BDCursosCubit>().actualizarUnidadesCurso(curso);

   
  
  }

  // retornar lista de estudiantes dado una lista de Ids
  List<Estudiante> obtenerEstudiantesPorIds(List<int> ids) {
    final estadoActual = state;
    return estadoActual.estudiantes!
        .where((estudiante) => ids.contains(estudiante.id))
        .toList();
  }

  // retorna lista de Actividades de la lista de Unidades
  List<Actividad> obtenerTodasActividadesCurso() {
    List<Actividad> todasLasActividades = [];
    for (var i = 0; i < state.unidades!.length; i++) {
      for (var j = 0; j < state.unidades![i].actividades!.length; j++) {
        todasLasActividades.add(state.unidades![i].actividades![j]);
      }
    }

    return todasLasActividades; // Si no se encuentra la actividad
  }
}
