import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Firestore Integration Test', () {
    late FirebaseFirestore firestore;

    setUp(() {
      firestore = FirebaseFirestore.instance;
    });

    test('Subir curso, unidades y seguimientos', () async {
      // 1. Subir curso
      var docRef = await firestore.collection('cursos').add({
        'id': 7777,
        'nombre': 'Curso de prueba',
        'codigoAcceso': '12345',
        'departamento': 'Departamento de prueba',
        'ciudad': 'Ciudad de prueba',
        'colegio': 'Colegio de prueba',
        'profesor': 1,
        'portada': 'portada.png',
        'numEstudiantes': 30,
        'descripcion': 'Descripción del curso',
        'fechaCreacion': DateTime.now().toString(),
        'fechaFinalizacion': DateTime.now().add(Duration(days: 30)).toString(),
        'estado': true,
        'estudiantes': [],
      });

      // 2. Subir unidades relacionadas al curso
      await subirUnidadesFB(firestore, docRef.id);

      // 3. Subir seguimientos relacionados al curso
      await guardarSeguimientosFB(firestore, docRef.id);

      // Asserts para verificar los resultados esperados
      final snapshotCursos = await firestore.collection('cursos').get();
      expect(snapshotCursos.docs.length, 1);

      final snapshotUnidades = await firestore.collection('unidades').get();
      expect(snapshotUnidades.docs.isNotEmpty, true);

      final snapshotSeguimientos = await firestore.collection('seguimientos').get();
      expect(snapshotSeguimientos.docs.isNotEmpty, true);
    });
  });
}

Future<void> subirUnidadesFB(FirebaseFirestore firestore, String cursoId) async {
  var unidades = [
    {
      'id': 'U1',
      'nombre': 'Unidad 1',
      'descripcion': 'Introducción a la programación',
      'estado': true,
      'cursoId': cursoId,
      'actividades': [
        {'id': 'A1', 'nombre': 'Secuencias'},
        {'id': 'A2', 'nombre': 'Ciclos'},
      ]
    },
    {
      'id': 'U2',
      'nombre': 'Unidad 2',
      'descripcion': 'Programación Avanzada',
      'estado': true,
      'cursoId': cursoId,
      'actividades': [
        {'id': 'A3', 'nombre': 'Herencia y Polimorfismo'},
        {'id': 'A4', 'nombre': 'Manejo de Excepciones'},
      ]
    },
  ];

  for (var unidad in unidades) {
    await firestore.collection('unidades').add(unidad);
  }
}

Future<void> guardarSeguimientosFB(FirebaseFirestore firestore, String cursoId) async {
  var seguimientos = [
    {
      'id': 'S1',
      'respuestasActividades': [{'respuesta': 'Correcta', 'puntaje': 10}],
      'calificacion': 85.0,
      'userId': '123',
      'cursoId': cursoId,
    },
    {
      'id': 'S2',
      'respuestasActividades': [{'respuesta': 'Incorrecta', 'puntaje': 5}],
      'calificacion': 70.0,
      'userId': '456',
      'cursoId': cursoId,
    },
  ];

  for (var seguimiento in seguimientos) {
    await firestore.collection('seguimientos').add(seguimiento);
  }
}
