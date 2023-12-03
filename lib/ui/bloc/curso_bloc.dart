import 'package:dev_tesis/domain/model/curso.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit para manejar el estado del nombre completo
class CursoCubit extends Cubit<Curso> {
  CursoCubit() : super(Curso());

  // Método para cambiar el nombre
  void actualizarCurso(Curso curso) {
    emit(curso);
  }
}
