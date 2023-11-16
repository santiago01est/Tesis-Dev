import 'package:dev_tesis/domain/model/curso.dart';

abstract class CursoRepository {
  Future<List<Curso>> getCursos();
}
