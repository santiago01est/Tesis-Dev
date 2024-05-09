import 'package:dev_tesis/domain/model/respuesta.dart';

class Seguimiento {
  int? id;
  List<Respuesta>? respuestasActividades;
  List<int>? test;
  double? calificacion;
  int? userId;
  int? cursoId;

  Seguimiento(
      {this.id,
      this.respuestasActividades,
      this.test,
      this.calificacion,
      this.userId,
      this.cursoId});

  Seguimiento copyWith({
    int? id,
    List<Respuesta>? respuestasActividades,
    List<int>? test,
    double? calificacion,
    int? userId,
    int? cursoId,
  }) {
    return Seguimiento(
      id: this.id,
      respuestasActividades:
          respuestasActividades ?? this.respuestasActividades,
      test: test ?? this.test,
      calificacion: calificacion ?? this.calificacion,
      userId: userId ?? this.userId,
      cursoId: cursoId ?? this.cursoId,
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'respuestasActividades': respuestasActividades?.map((x) => x.toMap()).toList(),
      'test': test,
      'calificacion': calificacion,
      'userId': userId,
      'cursoId': cursoId,
    };
    
  }

  void fromMap(Map<String, dynamic> data) {
    id = data['id'];
    if (data['respuestasActividades'] != null) {
      respuestasActividades = (data['respuestasActividades'] as List<dynamic>)
          .map((respuesta) => Respuesta.fromJson(respuesta))
          .toList();
    }
    test = data['test'];
    calificacion = data['calificacion'];
    userId = data['userId'];
    cursoId = data['cursoId'];
  
  }
}
