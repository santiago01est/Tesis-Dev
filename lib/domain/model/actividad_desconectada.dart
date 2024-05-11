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
      this.ejercicioImage,
      this.ejemploImage});

      @override
        Map<String, dynamic> toMap() {
    return {
      ...super.toMap(), // Llama al método toMap de la clase madre
      'ejercicioImage': ejercicioImage,
      'ejemploImage': ejemploImage,
    };
  }

  factory ActividadDesconectada.fromJson(Map<String, dynamic> json) {
    return ActividadDesconectada(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      tipoActividad: json['tipoActividad'],
      pesoRespuestas: json['pesoRespuestas'],
      habilidades: json['habilidades'],
      ejercicioImage: json['ejercicioImage'],
      ejemploImage: json['ejemploImage'],
    );
  }
}
