//clase cuestionario que extiende de actividad
import 'package:dev_tesis/domain/model/actividad.dart';

class ActividadCuestionario extends Actividad {
  int? dimension;
  List<int>? casillas;
  List<List<Object>>? respuestas;
  String? ejercicioImage;
  String? ejemploImage;
  String? pista;
  int? respuestaCorrecta;

  ActividadCuestionario(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      this.dimension,
      this.casillas,
      this.respuestas,
      this.ejercicioImage,
      this.ejemploImage,
      this.pista,
      this.respuestaCorrecta});

  //Tostring
  @override
  String toString() {
    return 'ActividadCuestionario: $id, $nombre, $dimension, $casillas, $respuestas, $ejercicioImage, $ejemploImage, $pista, $respuestaCorrecta, $habilidades, $estado, ${pesoRespuestas}';
  }

   @override
     Map<String, dynamic> toMap() {
    return {
      ...super.toMap(), // Llama al método toMap de la clase madre
      'dimension': dimension,
      'casillas': casillas,
      'respuestas': respuestas,
      'ejercicioImage': ejercicioImage,
      'ejemploImage': ejemploImage,
      'pista': pista,
      'respuestaCorrecta': respuestaCorrecta,
    };
  }

  factory ActividadCuestionario.fromJson(Map<String, dynamic> json) {
    return ActividadCuestionario(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      tipoActividad: json['tipoActividad'],
      pesoRespuestas: json['pesoRespuestas'],
      habilidades: json['habilidades'],
      dimension: json['dimension'],
      casillas: json['casillas'] != null ? List<int>.from(json['casillas']) : null,
      respuestas: json['respuestas'] != null ? List<List<Object>>.from(json['respuestas']) : null,
      ejercicioImage: json['ejercicioImage'],
      ejemploImage: json['ejemploImage'],
      pista: json['pista'],
      respuestaCorrecta: json['respuestaCorrecta'],
    );
  }
}
