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
      { super.id,
       super.nombre,
       super.descripcion,
       super.estado,
       super.tipoActividad,
       super.pesoRespuestas,
       this.dimension,
       this.casillas,
       this.respuestas,
   
       this.ejercicioImage,
       this.ejemploImage,
       this.pista,
       this.respuestaCorrecta});
}
