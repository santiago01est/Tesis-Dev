import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/domain/repository/profesor_respository.dart';

class ProfesorDataAdapter extends ProfesorRepository {
  @override
  Future<Profesor> getProfesorById(String id) {
    // TODO: implement getProfesorById
    throw UnimplementedError();
  }

  @override
  Future<List<Profesor>> getProfesores() {
    // TODO: implement getProfesores
    Profesor p1 = Profesor(
        id: 1,
        nombre: 'SNS',
        email: 'santiagoestrada.dev@gmail.com',
        password: '1234_567',
        avatar: 'assets/items/perico_mascota.png',
        bio:
            'Apasionado por la enseñanza del pensamiento computacional! 👩‍🏫, Promuevo el uso de la tecnología en los estudiantes');

    return Future.value([p1]);
  }
}
