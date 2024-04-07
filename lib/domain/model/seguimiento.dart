class Seguimiento {
  int? id;
  List<int>? respuestasActividades;
  List<String>? test;
  double? calificacion;
  int? userId;
  int? cursoId;

  Seguimiento({
    this.id,
    this.respuestasActividades,
    this.test,
    this.calificacion,
    this.userId,
    this.cursoId
  });

  Seguimiento copyWith({
    List<int>? respuestasActividades,
    List<String>? test,
    double? calificacion,
    int? userId,
    int? cursoId,
  }) {
    return Seguimiento(
      id: this.id,
      respuestasActividades: respuestasActividades ?? this.respuestasActividades,
      test: test ?? this.test,
      calificacion: calificacion ?? this.calificacion,
      userId: userId ?? this.userId,
      cursoId: cursoId ?? this.cursoId,
    );
  }
}
