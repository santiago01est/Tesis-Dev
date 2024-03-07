import 'package:dev_tesis/domain/model/actividad.dart';

class Unidad {
  String? id;
  String? nombre;
  String? descripcion;
  String? estado;
  List<Actividad>? actividades;

  Unidad(
      {this.id, this.nombre, this.descripcion, this.estado, this.actividades});


}
