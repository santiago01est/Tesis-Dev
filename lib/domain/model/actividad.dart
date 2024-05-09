class Actividad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;

  Actividad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.tipoActividad,
      this.pesoRespuestas,
      this.habilidades});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
      'tipoActividad': tipoActividad,
      'pesoRespuestas': pesoRespuestas,
      'habilidades': habilidades,
    };
    
  }

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      tipoActividad: json['tipoActividad'],
      pesoRespuestas: json['pesoRespuestas'] != null
          ? List<int>.from(json['pesoRespuestas'])
          : null,
      habilidades: json['habilidades'] != null
          ? List<int>.from(json['habilidades'])
          : null,
    );
  }
}
