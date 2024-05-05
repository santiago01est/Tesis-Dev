class Respuesta {
  int? id;
  String? respuestaUsuario;
  int? peso;
  int? actividadId;

  Respuesta({this.id, this.respuestaUsuario, this.peso, this.actividadId});

  Respuesta copyWith({
    int? id,
    String? respuestaUsuario,
    int? peso,
    int? actividadId,
  }) {
    return Respuesta(
      id: this.id,
      respuestaUsuario: respuestaUsuario ?? this.respuestaUsuario,
      peso: peso ?? this.peso,
      actividadId: actividadId ?? this.actividadId,
    );
  }
}
