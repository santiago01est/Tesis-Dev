import 'package:dev_tesis/domain/model/actividad.dart';

class Unidad {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  List<Actividad>? actividades;
  int cursoId;

  Unidad(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.actividades,
      required this.cursoId});
}
