import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstudiantesCubit extends Cubit<List<Estudiante>> {
  EstudiantesCubit() : super([]);

  void agregarEstudiante(Estudiante nuevoEstudiante) {
    List<Estudiante> estudiantes = List.from(state); // Crea una nueva lista
    estudiantes.add(nuevoEstudiante);
    emit(estudiantes);
  }

  //metodo que retorna una lista con los ids de los estudiantes
  List<int> obtenerIds() {
    List<int> ids = [];
    for (Estudiante estudiante in state) {
      ids.add(estudiante.id!);
    }
    return ids;
  }

  // Retornar nombre de los estudiantes como string
  String obtenerNombres() {
    String nombres = '';
    for (Estudiante estudiante in state) {
      // si el estudiantes es el ultimo no se agrega coma
      if (state.indexOf(estudiante) != state.length - 1) {
        nombres += '${estudiante.nombre} - ';
      } else {
        nombres += '${estudiante.nombre}';
      }
    }
    return nombres;
  }
}
