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
}
