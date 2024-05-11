import 'package:dev_tesis/domain/model/actividad.dart';
import 'package:dev_tesis/game/player/player.dart';

class ActividadLaberinto extends Actividad {
  String? nombreArchivo;
  List<dynamic> mejorCamino;
  List<dynamic>? mejorCamino2;
  PlayerState initialState;

  ActividadLaberinto(
      {super.id,
      super.nombre,
      super.descripcion,
      super.estado,
      super.tipoActividad,
      super.pesoRespuestas,
      super.habilidades,
      this.nombreArchivo,
      required this.mejorCamino,
      this.mejorCamino2 = const [],
      required this.initialState});
}
