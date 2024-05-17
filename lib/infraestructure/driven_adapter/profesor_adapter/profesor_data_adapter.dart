import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/domain/repository/profesor_respository.dart';

class ProfesorDataAdapter extends ProfesorRepository {
  @override
  Future<Profesor> getProfesorById(String id) {
    // TODO: implement getProfesorById
    throw UnimplementedError();
  }

  @override
  Future<List<Profesor>> getProfesores() async {

    List<Profesor> profesores = [];
    // TODO: implement getProfesores
    Profesor p1 = Profesor(
        id: 1,
        nombre: 'SNS',
        email: 'santiagoestrada.dev@gmail.com',
        password: '1234_567',
        avatar: 'assets/items/perico_mascota.png',
        bio:
            'Apasionado por la enseñanza del pensamiento computacional! 👩‍🏫, Promuevo el uso de la tecnología en los estudiantes');


/// obtener los cursos de la base de datos

    // Referencia a la colección "cursos" en Firestore
    CollectionReference profesoresRef =
        FirebaseFirestore.instance.collection('profesores');

    // Obtener los documentos de la colección
    QuerySnapshot querySnapshot = await profesoresRef.get();

    // Iterar sobre cada documento obtenido
    for (var doc in querySnapshot.docs) {
      // Crear un objeto Curso
      Profesor profesor = Profesor();
      // Leer los datos del documento y guardarlos en el objeto profesor

      profesor.fromMap(doc.data() as Map<String, dynamic>);
      // Agregar el objeto profesor a la lista de profesors
      profesores.add(profesor);
    }

  profesores.add(p1);
    return profesores;
  }
}
