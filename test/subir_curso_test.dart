import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/infraestructure/firebase/firebase_curso.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Mocks generados por Mockito
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  /*
  group('subirCursoFB', () {
    test('sube un curso a Firestore', () async {
       late MockFirebaseFirestore mockFirestore;
    late FirebaseService firebaseService;


    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      firebaseService = FirebaseService(firestore: mockFirestore);
    });


 // Mocking the Firestore collection and document references
      final mockCollectionReference = MockCollectionReference();
      final mockDocumentReference = MockDocumentReference();
     

      // Configura los mocks
      when(mockFirestore.collection('cursos')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any!)).thenAnswer((_) async => mockDocumentReference);

      // Crea una instancia de tu servicio
      final cursoService = FirebaseService(firestore: mockFirestore);

      // Crea un curso de prueba
      final curso = Curso(
        id: 7777,
        nombre: 'Curso de prueba',
        codigoAcceso: '12345',
        departamento: 'Departamento de prueba',
        ciudad: 'Ciudad de prueba',
        colegio: 'Colegio de prueba',
        profesor: 1,
        portada: 'portada.png',
        numEstudiantes: 30,
        descripcion: 'Descripción del curso',
        fechaCreacion: '$DateTime.now()',
        fechaFinalizacion: '$DateTime.now().add(Duration(days: 30))',
        estado: true,
        estudiantes: [],
      );

      // Llama a la función
      await cursoService.subirCursoFB(curso);

      // Verifica que la función add fue llamada una vez
      verify(mockCollectionReference.add(any!)).called(1);
    });
  });
}
*/
}

class CursoService {}
