import 'package:dev_tesis/domain/model/actividad.dart';

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  Map<String, bool>? respuesta;

  ActividadLaberinto(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      this.nombreArchivo,
      this.respuesta
  });
}
