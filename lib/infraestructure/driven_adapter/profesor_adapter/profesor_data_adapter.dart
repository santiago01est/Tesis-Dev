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
        id: '1',
        nombre: 'Ángela Maria Muñoz Muñoz',
        email: 'Correo 1',
        password: '',
        avatar: 'assets/items/perico_mascota.png',
        bio:
            'Apasionada por la enseñanza del pensamiento computacional! 👩‍🏫, soy profesora de la Institución Educativa General Santander Calarcá, Quindío. Transformo el aprendizaje en aventuras emocionantes para mis estudiantes y fomentar el poder de la tecnologia y de la creatividad');
    Profesor p2 = Profesor(
        id: '2',
        nombre: 'Profesor 1',
        email: 'Correo 1',
        password: '',
        avatar: 'assets/items/perico_mascota.png',
        bio: '');
    Profesor p3 = Profesor(
        id: '3',
        nombre: 'Profesor 1',
        email: 'Correo 1',
        password: '',
        avatar: 'assets/items/perico_mascota.png',
        bio: '');
    Profesor p4 = Profesor(
        id: '4',
        nombre: 'Profesor 1',
        email: 'Correo 1',
        password: '',
        avatar: 'assets/items/perico_mascota.png',
        bio: '');

    Profesor p5 = Profesor(
        id: '5',
        nombre: 'Profesor 1',
        email: 'Correo 1',
        password: '',
        avatar: 'assets/items/perico_mascota.png',
        bio: '');

    return Future.value([p1, p2, p3, p4, p5]);
  }
}
