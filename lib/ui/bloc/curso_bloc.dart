import 'package:dev_tesis/domain/casos_uso/curso_casos_uso/curso_cs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_tesis/domain/model/curso.dart';

// Evento para solicitar los cursos
class GetCursosEvent extends Cubit<void> {
  final CursosCasoUso cursosCasoUso;

  GetCursosEvent(this.cursosCasoUso) : super(null);

  void getCursos() async {
    try {
      List<Curso> cursos = await cursosCasoUso.getCursos();
      emit(cursos); // Emitir los cursos obtenidos
    } catch (e) {
      // Manejar el error, por ejemplo: emit(LoadingFailed());
    }
  }
}

// Bloc para administrar el estado de los cursos
class CursosBloc extends Cubit<List<Curso>> {
  final CursosCasoUso cursosCasoUso;

  CursosBloc(this.cursosCasoUso) : super([]);

  void obtenerCursos() async {
    try {
      List<Curso> cursos = await cursosCasoUso.getCursos();
      emit(cursos); // Actualizar el estado con los cursos obtenidos
    } catch (e) {
      // Manejar el error, por: emit([]);
    }
  }
}
