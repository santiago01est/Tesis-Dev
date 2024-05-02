import 'package:dev_tesis/domain/model/grupo.dart';
import 'package:dev_tesis/domain/repository/grupo_repository.dart';

class GrupoCasoUso {
  final GrupoRepository grupoRepository;
  GrupoCasoUso(this.grupoRepository);

  Future<List<Grupo>> getGrupos(idCurso) => grupoRepository.getGrupos(idCurso);
}
