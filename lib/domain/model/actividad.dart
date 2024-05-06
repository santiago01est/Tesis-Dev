class Actividad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  int? indice;
  String? tipoActividad;
  List<int>? pesoRespuestas;
  List<int>? habilidades;

  Actividad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.indice,
      this.tipoActividad,
      this.pesoRespuestas,
      this.habilidades});
}
