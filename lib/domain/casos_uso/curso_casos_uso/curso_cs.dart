import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;
  CursosCasoUso(this.cursoRepository);
  Future<List<Curso>> getCursos() => cursoRepository.getCursos();

  void guardarCurso(Curso curso) {
    cursoRepository.guardarCurso(curso);
  }
}
