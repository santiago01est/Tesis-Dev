import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/estudiante.dart';
import 'package:dev_tesis/domain/repository/curso_repository.dart';

class CursosCasoUso {
  final CursoRepository cursoRepository;
  CursosCasoUso(this.cursoRepository);
  Future<List<Curso>> getCursos() => cursoRepository.getCursos();

  void guardarCurso(String text, String text2, String text3,
      String selectedImages, String s, List<Estudiante> listaEstudiantes) {
    Curso curso = Curso(
        nombre: text,
        codigoAcceso: text2,
        colegio: text3,
        portada: selectedImages,
        estado: s);
    //cursoRepository.guardarCurso(curso);
  }
}
