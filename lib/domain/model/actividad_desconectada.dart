import 'package:dev_tesis/domain/model/actividad.dart';

class ActividadDesconectada extends Actividad {
  String? ejercicioImage;
  String? ejemploImage;

  ActividadDesconectada(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.indice,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      this.ejercicioImage,
      this.ejemploImage});
}
