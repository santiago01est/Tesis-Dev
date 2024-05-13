class Actividad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;
  String? pista;
  int? unidadId;

  Actividad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.tipoActividad,
      this.pesoRespuestas,
      this.habilidades,
      this.pista,
      this.unidadId});

  // To Map
  factory Actividad.fromFirestore(Map<String, dynamic> data) {
    return Actividad(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      pista: data['pista'],
      unidadId: data['unidadId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "estado": estado,
      "tipoActividad": tipoActividad,
      "pesoRespuestas": pesoRespuestas,
      "habilidades": habilidades,
      "pista": pista,
      "unidadId": unidadId,
    };
  }
}
