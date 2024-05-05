import 'package:dev_tesis/domain/model/unidad.dart';

abstract class UnidadRepository {
  Future<List<Unidad>> getUnidades(int idCurso);
}
