import 'package:dev_tesis/domain/model/profesor.dart';

abstract class ProfesorRepository {
  Future<List<Profesor>> getProfesores();
  Future<Profesor> getProfesorById(String id);
}
