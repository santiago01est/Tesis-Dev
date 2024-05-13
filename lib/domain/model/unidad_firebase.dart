import 'package:dev_tesis/domain/model/actividad_global_fb.dart';

class UnidadFirebase {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;
  List<ActividadGlobalFB>? actividades;
  int cursoId;

  UnidadFirebase(
      {this.id,
      this.nombre,
      this.descripcion,
      this.estado,
      this.actividades,
      required this.cursoId});


      // To Map
   factory UnidadFirebase.fromFirestore(Map<String, dynamic> data) {
    return UnidadFirebase(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      cursoId: data['cursoId'],
      actividades: (data['actividades'] as List<dynamic>?)
          ?.map((actividadData) => ActividadGlobalFB.fromFirestore(actividadData))
          .toList(),
      
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "nombre": nombre,
      "descripcion": descripcion,
      "estado": estado,
      "cursoId": cursoId,
      "actividades": actividades?.map((actividad) => actividad.toFirestore()).toList(),
    };
  }

 
}
