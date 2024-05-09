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

      // metodo toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
      'actividades': actividades?.map((actividades) => actividades.toMap()).toList(),
      'cursoId': cursoId,
    };
  }

   factory Unidad.fromJson(Map<String, dynamic> json) {
    return Unidad(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      actividades: (json['actividades'] as List<dynamic>?)
          ?.map((actividad) => Actividad.fromJson(actividad))
          .toList(),
      cursoId: json['cursoId'],
    );
  }
}
