import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/unidad.dart';
import 'package:dev_tesis/domain/repository/unidad_repository.dart';

class UnidadCasoUso {
  final UnidadRepository unidadRepository;
  UnidadCasoUso(this.unidadRepository);

  Future<List<Unidad>> getUnidades(String idCurso) {
    return unidadRepository.getUnidades(idCurso);
  }

  int numeroTotalActividades(Curso curso) {
    // cuenta el numero total de actividades que tiene cada unidad de listaUnidades
    int numeroTotalActividades = 0;
    for (int i = 0; i < curso.unidades!.length; i++) {
      for (int j = 0; j < curso.unidades![i].actividades!.length; j++) {
        numeroTotalActividades++;
      }
    }
    return numeroTotalActividades;
  }
}
