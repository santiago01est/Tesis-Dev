import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del profesor
class EstudianteCubit extends Cubit<Estudiante> {
  EstudianteCubit() : super(Estudiante());

  // Método para actualizar el profesor
  void actualizarProfesor(Estudiante estudiante) {
    emit(estudiante);
  }
}

class EstudiantesCubit extends Cubit<List<Estudiante>> {
  EstudiantesCubit() : super([]);



  void agregarEstudiante(Estudiante nuevoEstudiante) {
    List<Estudiante> estudiantes= List.from(state); // Crea una nueva lista
    estudiantes.add(nuevoEstudiante);
    emit(estudiantes);
  }
}
