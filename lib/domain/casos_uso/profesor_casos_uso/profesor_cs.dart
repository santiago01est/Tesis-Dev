import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/domain/repository/profesor_respository.dart';

class ProfesorCasoUso {
  final ProfesorRepository profesorRepository;
  ProfesorCasoUso(this.profesorRepository);

  Future<List<Profesor>> getProfesores() {
    return profesorRepository.getProfesores();
  }
}
