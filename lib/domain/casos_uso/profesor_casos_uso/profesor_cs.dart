import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/profesor.dart';
import 'package:dev_tesis/domain/repository/profesor_respository.dart';

class ProfesorCasoUso {
  final ProfesorRepository profesorRepository;
  ProfesorCasoUso({required this.profesorRepository});

  Future<List<Profesor>> getProfesores() {
    return profesorRepository.getProfesores();
  }

  void subirProfesorFB(Profesor profesor) {
    // Referencia a la colección "productos" en Firestore
    CollectionReference productos =
        FirebaseFirestore.instance.collection('profesores');

    // Convertir el objeto Producto a un mapa
    Map<String, dynamic> data = profesor.toMap();

    // Agregar el documento a la colección
    productos.add(data).then((value) {
      print('Profesor agregado con ID: ${value.id}');
    }).catchError((error) {
      print('Error al agregar el Profesor: $error');
    });
  }
}
