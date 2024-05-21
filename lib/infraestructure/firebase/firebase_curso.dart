import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_tesis/domain/model/curso.dart';
import 'package:dev_tesis/domain/model/curso_firebase.dart';


class FirebaseService {
  final FirebaseFirestore firestore;

  FirebaseService({required this.firestore});

  Future<void> subirCursoFB(Curso curso) async {
    CollectionReference cursosRef = firestore.collection('cursos');

    CursoFirebase cursoFirebase = CursoFirebase(
      id: curso.id,
      nombre: curso.nombre,
      codigoAcceso: curso.codigoAcceso,
      departamento: curso.departamento,
      ciudad: curso.ciudad,
      colegio: curso.colegio,
      profesor: curso.profesor,
      portada: curso.portada,
      numEstudiantes: curso.numEstudiantes,
      descripcion: curso.descripcion,
      fechaCreacion: curso.fechaCreacion,
      fechaFinalizacion: curso.fechaFinalizacion,
      estado: curso.estado,
      estudiantes: curso.estudiantes,
    );

    //Subir curso
    final cursoMap = cursoFirebase.toFirestore();
    await cursosRef.add(cursoMap);
  }
}