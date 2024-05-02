import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class CursoCubit extends Cubit<Curso> {
  CursoCubit() : super(Curso());

  // Método para cambiar el nombre
  void actualizarCurso(Curso curso) {
    emit(curso);
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

  // retornar lista de estudiantes dado una lista de Ids
  List<Estudiante> obtenerEstudiantesPorIds(List<int> ids) {
    final estadoActual = state;
    return estadoActual.estudiantes!
        .where((estudiante) => ids.contains(estudiante.id))
        .toList();
  }
}
