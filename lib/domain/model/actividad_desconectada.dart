import 'package:dev_tesis/domain/model/actividad.dart';

class ActividadDesconectada extends Actividad {
  String? ejercicioImage;
  String? ejemploImage;

  ActividadDesconectada(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      super.pista,
      this.ejercicioImage,
      this.ejemploImage});

  factory ActividadDesconectada.fromJson(Map<String, dynamic> json) {
    return ActividadDesconectada(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      pista: json['pista'],
      tipoActividad: json['tipoActividad'],
      pesoRespuestas: json['pesoRespuestas'],
      habilidades: json['habilidades'],
      ejercicioImage: json['ejercicioImage'],
      ejemploImage: json['ejemploImage'],
    );
  }

  // To Map
  factory ActividadDesconectada.fromFirestore(Map<String, dynamic> data) {
    return ActividadDesconectada(
      id: data['id'],
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      estado: data['estado'],
      tipoActividad: data['tipoActividad'],
      pesoRespuestas: data['pesoRespuestas'],
      habilidades: data['habilidades'],
      pista: data['pista'],
      ejercicioImage: data['ejercicioImage'],
      ejemploImage: data['ejemploImage'],
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
      "ejercicioImage": ejercicioImage,
      "ejemploImage": ejemploImage,
    };
  }
}
