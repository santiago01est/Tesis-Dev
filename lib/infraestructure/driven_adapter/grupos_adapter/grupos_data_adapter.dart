import 'package:dev_tesis/domain/model/grupo.dart';
import 'package:dev_tesis/domain/repository/grupo_repository.dart';

class GrupoDataAdapter extends GrupoRepository {
  @override
  void eliminarGrupo(int idGrupo) {
    // TODO: implement eliminarGrupo
  }

  @override
  Future<List<Grupo>> getGrupos(int idCurso) {
    return Future.value([
      Grupo(id: 1, idEstudiante1: 1, idEstudiante2: 2),
    ]);
  }

  @override
  void guardarGrupo(Grupo grupo) {
    // TODO: implement guardarGrupo
  }
}
