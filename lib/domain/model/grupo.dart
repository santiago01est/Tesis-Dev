//clase estudiante
import 'package:cloud_firestore/cloud_firestore.dart';

class Grupo {
  int? id;
  int? idEstudiante1;
  int? idEstudiante2;
  int? cursoId;

  Grupo({this.id, this.idEstudiante1, this.idEstudiante2, this.cursoId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idEstudiante1': idEstudiante1,
      'idEstudiante2': idEstudiante2,
      'cursoId': cursoId,
    
    };
  }

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
