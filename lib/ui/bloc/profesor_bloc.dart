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
