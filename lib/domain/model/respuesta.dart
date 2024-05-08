class Respuesta {
  int? id;
  String? respuestaUsuario;
  int? peso;
  int? actividadId;
  int? seguimientoId;

  Respuesta(
      {this.id,
      this.respuestaUsuario,
      this.peso,
      this.actividadId,
      this.seguimientoId});

  Respuesta copyWith(
      {int? id,
      String? respuestaUsuario,
      int? peso,
      int? actividadId,
      int? seguimientoId}) {
    return Respuesta(
        id: this.id,
        respuestaUsuario: respuestaUsuario ?? this.respuestaUsuario,
        peso: peso ?? this.peso,
        actividadId: actividadId ?? this.actividadId,
        seguimientoId: seguimientoId ?? this.seguimientoId);
  }
}
