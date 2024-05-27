import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Firestore Integration Test', () {
    test('Subir curso', () async {
      final firestore = FakeFirebaseFirestore();
      await firestore.collection('cursos').add({
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
        'fechaCreacion': DateTime.now(),
        'fechaFinalizacion': DateTime.now().add(Duration(days: 30)),
        'estado': true,
        'estudiantes': [],
      });

      final snapshot = await firestore.collection('cursos').get();

      expect(snapshot.docs.length, 1);

      print('El test de "Subir curso" se realizó correctamente. Validación de creación correcta.');

      // // 2. Subir unidades relacionadas al curso
      // await subirUnidadesFB(firestore, docRef.id);

      // // 3. Subir seguimientos relacionados al curso
      // await guardarSeguimientosFB(firestore, docRef.id);

      // // Asserts para verificar los resultados esperados
      // final snapshotCursos = await firestore.collection('cursos').get();
      // expect(snapshotCursos.docs.length, 1);

      // final snapshotUnidades = await firestore.collection('unidades').get();
      // expect(snapshotUnidades.docs.isNotEmpty, true);

      // final snapshotSeguimientos = await firestore.collection('seguimientos').get();
      // expect(snapshotSeguimientos.docs.isNotEmpty, true);
    });
    test('Subir unidad', () async {
      final firestore = FakeFirebaseFirestore();
      await firestore.collection('unidades').add({
        'id': 'U1',
        'nombre': 'Unidad 1',
        'descripcion': 'Introducción a la programación',
        'estado': true,
        'cursoId': '7777',
        'actividades': [
          {'id': 'A1', 'nombre': 'Secuencias'},
          {'id': 'A2', 'nombre': 'Ciclos'},
        ]
      });

      final snapshot = await firestore.collection('unidades').get();

      expect(snapshot.docs.length, 1);

      print('El test de "Subir unidad" se realizó correctamente. Validación de creación correcta.');
    });
    test('Guardar seguimiento', () async {
      final firestore = FakeFirebaseFirestore();
      await firestore.collection('seguimiento').add({
        'id': 'S1',
        'respuestasActividades': [
          {
            'actividadId': 1,
            'id': 3,
            'peso': 4,
            'respuestaUsuario': '',
            'seguimientoId': 3,
          },
          {
            'actividadId': 2,
            'id': 3,
            'peso': 4,
            'respuestaUsuario': '',
            'seguimientoId': 3,
          },
        ],
        'test': [1, 2, 3],
        'calificacion': 85.0,
        'userId': '123',
        'cursoId': '7777',
      });

      final snapshot = await firestore.collection('seguimiento').get();

      expect(snapshot.docs.length, 1);

      print('El test de "Guardar seguimiento" se realizó correctamente. Validación de creación correcta.');
    });
  });
}
