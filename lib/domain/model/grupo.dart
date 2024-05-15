//clase estudiante
import 'package:cloud_firestore/cloud_firestore.dart';

class Grupo {
  int? id;
  int? idEstudiante1;
  int? idEstudiante2;
  int? cursoId;

  Grupo({this.id, this.idEstudiante1, this.idEstudiante2, this.cursoId});

  factory Grupo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Grupo(
      id: data?['id'],
      idEstudiante1: data?['idEstudiante1'],
      idEstudiante2: data?['idEstudiante2'],
      cursoId: data?['cursoId'],
    );
  }
}
