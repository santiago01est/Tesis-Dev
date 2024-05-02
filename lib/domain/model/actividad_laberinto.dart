import 'package:dev_tesis/domain/model/actividad.dart';

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  List<dynamic> mejorCamino;
  List<dynamic>? mejorCamino2;

  ActividadLaberinto(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.indice,
      super.tipoActividad,
      super.pesoRespuestas,
      this.nombreArchivo,
      required this.mejorCamino,
      this.mejorCamino2 = const []
  });
}
