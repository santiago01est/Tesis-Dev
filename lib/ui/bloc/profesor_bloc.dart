import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del profesor
class ProfesorCubit extends Cubit<Profesor> {
  ProfesorCubit() : super(Profesor());

  // Método para actualizar el profesor
  void actualizarProfesor(Profesor profesor) {
    emit(profesor);
  }
}

class ProfesoresCubit extends Cubit<List<Profesor>> {
  ProfesoresCubit() : super([]);

  void subirProfesores(List<Profesor> profesores) {
    emit(profesores);
  }

  void limpiarCubit() {
    emit([]);
  }

  void agregarProfesor(Profesor nuevoProfesor) {
    List<Profesor> profesores = List.from(state); // Crea una nueva lista
    profesores.add(nuevoProfesor);
    emit(profesores);
  }
}
