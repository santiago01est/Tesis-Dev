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


// obtener los cursos de la base de datos

    // Referencia a la colección "cursos" en Firestore
  CollectionReference profesoresref =
      FirebaseFirestore.instance.collection('profesores');

  // Obtener los documentos de la colección
  QuerySnapshot querySnapshot = await profesoresref.get();
  print(querySnapshot.docs[0].data());
  // Iterar sobre cada documento obtenido
  for (var doc in querySnapshot.docs) {
    // Verificar si los datos del documento no son null
  if (doc.data() != null) {
    // Crear un objeto Profesor
    Profesor profesor = Profesor();
    // Leer los datos del documento y guardarlos en el objeto Profesor
    profesor.fromMap(doc.data() as Map<String, dynamic>);
    // Agregar el objeto Profesor a la lista de profesores
    profesores.add(profesor);
  }
    
  }

  profesores.add(p1);
    return Future.value(profesores);
  }
}
