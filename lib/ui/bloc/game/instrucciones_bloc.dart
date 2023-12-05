import 'package:flutter_bloc/flutter_bloc.dart';

class InstruccionesCubit extends Cubit<List<String>> {
  InstruccionesCubit() : super([]);

  // Método para cambiar el nombre
  // void subirCursos(List<String> cursos) {
  //   emit(cursos);
  // }

  // Método para agregar un curso a la lista actual
  void agregarIntruccion(String instruccion) {
    List<String> cursos = List.from(state); // Crea una nueva lista
    cursos.add(instruccion);
    emit(cursos);
  }
}