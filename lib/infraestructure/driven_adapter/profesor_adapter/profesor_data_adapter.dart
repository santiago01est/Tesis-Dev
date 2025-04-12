import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/model/profesor.dart';
import '/domain/repository/profesor_respository.dart';

class ProfesorDataAdapter extends ProfesorRepository {
  final String baseUrl;

  ProfesorDataAdapter({this.baseUrl = 'http://localhost:8080'});

  @override
  Future<List<Profesor>> getProfesores() async {
    final uri = Uri.parse('$baseUrl/profesores');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> profesoresJson = jsonDecode(response.body);
      return profesoresJson.map((json) {
        return Profesor.fromJson(json);
      }).toList();
    } else {
      throw Exception('Error al obtener profesores: ${response.body}');
    }
  }

  @override
  Future<Profesor> getProfesorById(String id) async {
    // Suponemos que 'id' es numérico, pero se recibe como String para la interfaz.
    final uri = Uri.parse('$baseUrl/profesores/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Profesor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el profesor con id $id: ${response.body}');
    }
  }
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '/domain/model/profesor.dart';
import '/domain/repository/profesor_respository.dart';

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
*/