import 'package:dev_tesis/domain/model/grupo.dart';

abstract class GrupoRepository {
  Future<List<Grupo>> getGrupos(int idCurso);
  void guardarGrupo(Grupo grupo);
  void eliminarGrupo(int idGrupo);
}
